// On document ready
$(function() {

  // Global variables
  let landmarks;
  let questions;
  let score = 0;

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

    // Place landmarks on map
    for (i = 0; i < landmarks.length; i++) {
      let landmark = landmarks[i];
      let img = $('<img class="landmark">');
      img.data('landmarkid', landmark.id);
      img.attr('src', landmark.image);
      let css = 'top:' + landmark.top + '; left:' + landmark.left + '; width:' + landmark.width + ';';
      img.attr('style', css);
      img.appendTo('.map-area');
      img.wrap('<a href=""></a>');
    }
    console.log("Landmarks placed on map");

    // Make landmarks clickable
    $('.landmark').click(landmarkClicked);

    // Loading done
    $('.loading-button').hide();
    $('.start-button').show();

    // Start button
    $('.start-button').click(begin);

  } // --end csvLoaded

  // When start game
  function begin(e) {
    e.preventDefault();
    $('.welcome-area').hide();
    $('.map-area').show();
    $('.score-area').hide();
  }

  // When landmark clicked
  function landmarkClicked(e) {
    e.preventDefault();
    let id = $(this).data('landmarkid');
    console.log('Landmark ' + id + ' clicked');
    
    // Get question
    let question;
    for (i = 0; i < questions.length; i++) {
      if (questions[i].landmark == id) {
        question = questions[i];
        // @TODO more than one question per landmark
      }
    }

    // Make information screen
    $('.blurb-area .info-text').html('<h4>' + question.info + '</h4>');
    $('.blurb-area .info-pic').html('<p><img src="' + question.infopic + '"></p>');

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
      $(this).addClass('btn-danger');
    }
  }

  // When correct answer clicked
  function correctAnswerClicked() {
    let timetook = endTimer();
    $(".time-took").text("(" + timetook + " seconds)");
    score += 1;
    $(".score").text(score);
    $(".quiz-area").hide();
    $(".blurb-area").show();

    $(".to-map").click(function() {
      $(".map-area").show();
      $(".blurb-area").hide();
    });
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
