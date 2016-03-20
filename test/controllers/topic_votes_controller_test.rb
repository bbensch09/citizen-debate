require 'test_helper'

class TopicVotesControllerTest < ActionController::TestCase
  setup do
    @topic_vote = topic_votes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:topic_votes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create topic_vote" do
    assert_difference('TopicVote.count') do
      post :create, topic_vote: { value: @topic_vote.value }
    end

    assert_redirected_to topic_vote_path(assigns(:topic_vote))
  end

  test "should show topic_vote" do
    get :show, id: @topic_vote
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @topic_vote
    assert_response :success
  end

  test "should update topic_vote" do
    patch :update, id: @topic_vote, topic_vote: { value: @topic_vote.value }
    assert_redirected_to topic_vote_path(assigns(:topic_vote))
  end

  test "should destroy topic_vote" do
    assert_difference('TopicVote.count', -1) do
      delete :destroy, id: @topic_vote
    end

    assert_redirected_to topic_votes_path
  end
end
