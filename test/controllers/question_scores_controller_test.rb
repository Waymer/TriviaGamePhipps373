require 'test_helper'

class QuestionScoresControllerTest < ActionController::TestCase
  setup do
    @question_score = question_scores(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:question_scores)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create question_score" do
    assert_difference('QuestionScore.count') do
      post :create, question_score: { landmark_id: @question_score.landmark_id, question_id: @question_score.question_id, score: @question_score.score, time: @question_score.time }
    end

    assert_redirected_to question_score_path(assigns(:question_score))
  end

  test "should show question_score" do
    get :show, id: @question_score
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @question_score
    assert_response :success
  end

  test "should update question_score" do
    patch :update, id: @question_score, question_score: { landmark_id: @question_score.landmark_id, question_id: @question_score.question_id, score: @question_score.score, time: @question_score.time }
    assert_redirected_to question_score_path(assigns(:question_score))
  end

  test "should destroy question_score" do
    assert_difference('QuestionScore.count', -1) do
      delete :destroy, id: @question_score
    end

    assert_redirected_to question_scores_path
  end
end
