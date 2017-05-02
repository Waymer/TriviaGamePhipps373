// On document ready
$(function() {

  // Global variables
  let landmarks;
  let questions;
  let score = 0;
  let visited = new Set();
  let currentLandmark;
  let currentQuestion;
  let totalLandmarks;
  let maxScorePerQuestion = 4;
  let currentQuestionScore = maxScorePerQuestion;
  let gr_id;

  // Show welcome area
  $('.map-area').hide();
  $('.start-button').hide();
  $('.score-area').hide();

  // Load CSV of landmarks and questions
  $.when( $.ajax('landmarks.csv') , $.ajax('questions.csv') )
    .done( csvLoaded )
    .fail( function() { $('body').html('<h1>Something went wrong</h1>'); } );

  // CSV Loaded
  function csvLoaded(l, q) {
    console.log("CSV loaded");

    // Convert to JS objects
    landmarks = $.csv.toObjects(l[0]);
    questions = $.csv.toObjects(q[0]);
    console.log("CSV converted to JS objects");
    console.log(questions[0])
    // Total landmarks count
    totalLandmarks = landmarks.length;

    // Place landmarks on map
    for (i = 0; i < landmarks.length; i++) {
      let landmark = landmarks[i];
      if (landmark && landmark.top && landmark.left && landmark.width) {
        let img = $('<img class="landmark">');
        img.data('landmarkid', landmark.id);
        img.attr('src', landmark.image);
        let css = 'top:' + landmark.top + '; left:' + landmark.left + '; width:' + landmark.width + ';';
        img.attr('style', css);
        img.appendTo('.map-area');
        img.wrap('<a href=""></a>');

        let checkmark = $('<span class="glyphicon glyphicon-ok visited visited-' + landmark.id + '"></span>');
        let bottomright = parseInt(landmark.left) + parseInt(landmark.width) * 0.5 - 25;
        let checkmarkcss = 'top:' + landmark.top + '; left:' + bottomright + 'px;';
        checkmark.attr('style', checkmarkcss);
        checkmark.data('landmarkid', landmark.id);
        checkmark.hide()
        checkmark.appendTo('.map-area');
      }
    }
    console.log("Landmarks placed on map");

    // Make landmarks clickable
    $('.landmark').click(landmarkClicked);

    // Loading done
    $('.loading-button').hide();
    $('.start-button').show();

    // Start button
    $('.start-button').click(begin);

    // End button
    $('.end-button').click(endGameButton);

    // Help button
    $('.help-button').click(showTutorial);

    // Make tutorial clickable
    $('.tutorial-modal-content').click(function() {
      $('.tutorial').modal('hide');
    });

    $('.highscore-button').click(function(e) {
      e.preventDefault();
      $('.highscore').modal();
      getHighScores();
    });

  } // --end csvLoaded

  // Show Tutorial
  function showTutorial(e) {
    e.preventDefault();
    $('.tutorial').modal();
  }

  function getHighScores() {
    $.ajax({
        type: "GET",
        url: "game_record/top/",
        success: function(result) {
          console.log("Got high scores");
        },
        error: function(x, e) {
          console.log("Getting high scores went wrong");
        }
    });
  }
  // When game over
  function endGameButton(e) {
    e.preventDefault();
    endGame();
  }

  function endGame() {
    $('.map-area').hide();
    $('.score-area').hide();
    $('.gameover-area').show();
  }

  $('.submit-name').click(submitName);

  function submitName(e) {
    e.preventDefault();
    initials = document.getElementById('initials').value;
    // JSON holding question data
    //var gr2_data = '{' + ' "name":' + initials + '}'

    // ajax to call controller method for adding scores to db
    $.ajax(
    {
        type: "POST",
        url: "game_record/update/" + gr_id,
        dataType: "json",
        //data: $.param({ name: initials }),
        data: {"game_record": { name: initials }},
        success: function(result) {
          console.log("Updated game record");
        },
        error: function(x, e) {
          console.log("Updating game record went wrong");
        }
    });

    location.reload();
  }

  // When start game
  function begin(e) {
    e.preventDefault();
    $('.welcome-area').hide();
    $('.map-area').show();
    $('.score-area').show();
    $('.tutorial').modal();

    // JSON holding timestamp for game record
    //var gr_data = '{' + ' "timestamp":' + Math.floor(Date.now() / 1000) + '}'

    // ajax to call controller method for adding game record to db
    $.ajax(
    {
        type: "POST",
        url: "game_record/create",
        dataType: "json",
        // data: $.param({ timestamp: Math.floor(Date.now() / 1000) }),
        data: { "game_record": {name: "", timestamp: Math.floor(Date.now() / 1000) }},
        success: function(result) {
          gr_id = result.id;
          console.log("Created game record")
        },
        error: function(x, e) {
          // $('html').html(x.responseText);
          console.log("Creating game record went wrong")
        }
    });
  }

  // When landmark clicked
  function landmarkClicked(e) {
    e.preventDefault();
    let id = $(this).data('landmarkid');
    currentLandmark = id;
    console.log('Landmark ' + id + ' clicked');
    
    // Get question
    let availableQuestions = [];
    for (i = 0; i < questions.length; i++) {
      if (questions[i].landmark == id) {
        availableQuestions.push(questions[i]);
      }
    }
    let question = availableQuestions[Math.floor(Math.random() * availableQuestions.length)];
    console.log(question)
    currentQuestion = question.id
    // Make information screen
    $('.blurb-area .info-text').html('<h4>' + question.info + '</h4>');
    $('.blurb-area .info-pic').html('<p><img class="infopic" src="' + question.infopic + '"></p>');

    // Make question screen
    $('.quiz-area .question').text(question.question);
    let btn = '<button class="btn btn-default btn-lg btn-block"></button>';
    // currently assumes that ans1 is the correct answer for randomization
    let buttons = [
      $(btn).text(question.ans1).data('correct', true),
      $(btn).text(question.ans2),
      $(btn).text(question.ans3),
      $(btn).text(question.ans4)
    ]
    buttons.sort(function(a, b){return 0.5 - Math.random()}); // randomize answer order
    $('.quiz-area .answers').html('');
    $('.quiz-area .answers').append(buttons);

    // Make answers clickable
    $('.answers button').click(answerClicked);

    // Show question screen
    $('.map-area').hide();
    $('.quiz-area').show();
    startTimer();
  }

  // When answer clicked
  function answerClicked(e) {
    e.preventDefault();
    if ($(this).data('correct')) {
      $(this).addClass('btn-success');
      correctAnswerClicked();
    } else {
      // $(this).addClass('btn-danger');
      $(this).addClass('active');
      $(this).html($(this).text() + ' <span class="glyphicon glyphicon-remove text-danger"></span>');
      if (currentQuestionScore > 0) {
        currentQuestionScore -= 1;
      }
    }
  }

  // When correct answer clicked
  function correctAnswerClicked() {
    let timetook = endTimer();
    $(".time-took").text(timetook + " seconds");
    score += currentQuestionScore;
    // JSON holding question data
    //var qs_data = '{' + ' "landmark_id":' + currentLandmark + 
    //', "question_id":' + currentQuestion + 
    //', "score":' + currentQuestionScore + 
    //', "time":' + timetook + '}'

    // ajax to call controller method for adding scores to db
    console.log(currentQuestion)
    $.ajax(
    {
        type: "POST",
        url: "question_score/create",
        dataType: "json",
        // data: $.param({ landmark_id: currentLandmark, question_id: currentQuestion, score: currentQuestionScore, time: timetook }),
        data: {"question_score": { landmark_id: currentLandmark, 
                                    question_id: currentQuestion, 
                                    score: currentQuestionScore, 
                                    time: timetook,
                                    game_record_id: gr_id }
                                  },
        success: function(result) {
          console.log("submitted question score")
        },
        error: function(x, e) {
          console.log("submitting question score went wrong")
        }
    });

    currentQuestionScore = maxScorePerQuestion;
    $(".score").text(score);
    $(".quiz-area").hide();
    $(".blurb-area").show();

    $(".to-map").click(function() {
      console.log("Visited landmark #" + currentLandmark);
      visited.add(currentLandmark);
      $(".map-area").show();
      $(".blurb-area").hide();
      refreshVisited();
    });
  }

  // Show visited landmarks
  function refreshVisited() {
    visited.forEach(function(value) {
      $('.visited-' + value).show();
    });

    // Game over
    if (visited.size >= totalLandmarks) {
      endGame();
    }
  }

  // Timer
  let mytimer;
  let mytime = 0;

  let startTimer = function() {
    let start = new Date;
    mytime = 0;
    mytimer = setInterval(function() {
      mytime = Math.round((new Date - start) / 1000, 0);
      $('.timer').text(mytime + " seconds");
    }, 1000);
  };

  let endTimer = function() {
    clearInterval(mytimer);
    $('.timer').text("0 seconds");
    return mytime;
  };

});
