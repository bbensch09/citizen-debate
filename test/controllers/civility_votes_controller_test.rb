require 'test_helper'

class CivilityVotesControllerTest < ActionController::TestCase
  setup do
    @civility_vote = civility_votes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:civility_votes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create civility_vote" do
    assert_difference('CivilityVote.count') do
      post :create, civility_vote: { debate_id: @civility_vote.debate_id, debater_id: @civility_vote.debater_id, rating: @civility_vote.rating, voter_id: @civility_vote.voter_id }
    end

    assert_redirected_to civility_vote_path(assigns(:civility_vote))
  end

  test "should show civility_vote" do
    get :show, id: @civility_vote
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @civility_vote
    assert_response :success
  end

  test "should update civility_vote" do
    patch :update, id: @civility_vote, civility_vote: { debate_id: @civility_vote.debate_id, debater_id: @civility_vote.debater_id, rating: @civility_vote.rating, voter_id: @civility_vote.voter_id }
    assert_redirected_to civility_vote_path(assigns(:civility_vote))
  end

  test "should destroy civility_vote" do
    assert_difference('CivilityVote.count', -1) do
      delete :destroy, id: @civility_vote
    end

    assert_redirected_to civility_votes_path
  end
end
