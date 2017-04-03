require 'test_helper'

class RecordScoresControllerTest < ActionController::TestCase
  setup do
    @record_score = record_scores(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:record_scores)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create record_score" do
    assert_difference('RecordScore.count') do
      post :create, record_score: { gr_id: @record_score.gr_id, qs_id: @record_score.qs_id }
    end

    assert_redirected_to record_score_path(assigns(:record_score))
  end

  test "should show record_score" do
    get :show, id: @record_score
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @record_score
    assert_response :success
  end

  test "should update record_score" do
    patch :update, id: @record_score, record_score: { gr_id: @record_score.gr_id, qs_id: @record_score.qs_id }
    assert_redirected_to record_score_path(assigns(:record_score))
  end

  test "should destroy record_score" do
    assert_difference('RecordScore.count', -1) do
      delete :destroy, id: @record_score
    end

    assert_redirected_to record_scores_path
  end
end
