require 'test_helper'

class DebateVotesControllerTest < ActionController::TestCase
  setup do
    @debate_vote = debate_votes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:debate_votes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create debate_vote" do
    assert_difference('DebateVote.count') do
      post :create, debate_vote: { debate_id: @debate_vote.debate_id, user_id: @debate_vote.user_id, vote_for: @debate_vote.vote_for }
    end

    assert_redirected_to debate_vote_path(assigns(:debate_vote))
  end

  test "should show debate_vote" do
    get :show, id: @debate_vote
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @debate_vote
    assert_response :success
  end

  test "should update debate_vote" do
    patch :update, id: @debate_vote, debate_vote: { debate_id: @debate_vote.debate_id, user_id: @debate_vote.user_id, vote_for: @debate_vote.vote_for }
    assert_redirected_to debate_vote_path(assigns(:debate_vote))
  end

  test "should destroy debate_vote" do
    assert_difference('DebateVote.count', -1) do
      delete :destroy, id: @debate_vote
    end

    assert_redirected_to debate_votes_path
  end
end
