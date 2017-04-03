require 'test_helper'

class GameRecordsControllerTest < ActionController::TestCase
  setup do
    @game_record = game_records(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:game_records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create game_record" do
    assert_difference('GameRecord.count') do
      post :create, game_record: { name: @game_record.name, timestamp: @game_record.timestamp }
    end

    assert_redirected_to game_record_path(assigns(:game_record))
  end

  test "should show game_record" do
    get :show, id: @game_record
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @game_record
    assert_response :success
  end

  test "should update game_record" do
    patch :update, id: @game_record, game_record: { name: @game_record.name, timestamp: @game_record.timestamp }
    assert_redirected_to game_record_path(assigns(:game_record))
  end

  test "should destroy game_record" do
    assert_difference('GameRecord.count', -1) do
      delete :destroy, id: @game_record
    end

    assert_redirected_to game_records_path
  end
end
