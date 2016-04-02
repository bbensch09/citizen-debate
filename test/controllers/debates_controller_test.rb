require 'test_helper'

class DebatesControllerTest < ActionController::TestCase
  setup do
    @debate = debates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:debates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create debate" do
    assert_difference('Debate.count') do
      post :create, debate: { affirmative_id: @debate.affirmative_id, judge_left_id: @debate.judge_left_id, judge_right_id: @debate.judge_right_id, negative_id: @debate.negative_id, start_date: @debate.start_date, start_time: @debate.start_time, status: @debate.status, topic_id: @debate.topic_id, verdict_id: @debate.verdict_id }
    end

    assert_redirected_to debate_path(assigns(:debate))
  end

  test "should show debate" do
    get :show, id: @debate
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @debate
    assert_response :success
  end

  test "should update debate" do
    patch :update, id: @debate, debate: { affirmative_id: @debate.affirmative_id, judge_left_id: @debate.judge_left_id, judge_right_id: @debate.judge_right_id, negative_id: @debate.negative_id, start_date: @debate.start_date, start_time: @debate.start_time, status: @debate.status, topic_id: @debate.topic_id, verdict_id: @debate.verdict_id }
    assert_redirected_to debate_path(assigns(:debate))
  end

  test "should destroy debate" do
    assert_difference('Debate.count', -1) do
      delete :destroy, id: @debate
    end

    assert_redirected_to debates_path
  end
end
