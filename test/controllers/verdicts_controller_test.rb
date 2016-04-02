require 'test_helper'

class VerdictsControllerTest < ActionController::TestCase
  setup do
    @verdict = verdicts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:verdicts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create verdict" do
    assert_difference('Verdict.count') do
      post :create, verdict: { confirmed_judges: @verdict.confirmed_judges, confirmed_public: @verdict.confirmed_public, opinion_left: @verdict.opinion_left, opinion_right: @verdict.opinion_right, status: @verdict.status, winner: @verdict.winner }
    end

    assert_redirected_to verdict_path(assigns(:verdict))
  end

  test "should show verdict" do
    get :show, id: @verdict
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @verdict
    assert_response :success
  end

  test "should update verdict" do
    patch :update, id: @verdict, verdict: { confirmed_judges: @verdict.confirmed_judges, confirmed_public: @verdict.confirmed_public, opinion_left: @verdict.opinion_left, opinion_right: @verdict.opinion_right, status: @verdict.status, winner: @verdict.winner }
    assert_redirected_to verdict_path(assigns(:verdict))
  end

  test "should destroy verdict" do
    assert_difference('Verdict.count', -1) do
      delete :destroy, id: @verdict
    end

    assert_redirected_to verdicts_path
  end
end
