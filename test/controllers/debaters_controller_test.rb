require 'test_helper'

class DebatersControllerTest < ActionController::TestCase
  setup do
    @debater = debaters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:debaters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create debater" do
    assert_difference('Debater.count') do
      post :create, debater: { record: @debater.record, user_id: @debater.user_id }
    end

    assert_redirected_to debater_path(assigns(:debater))
  end

  test "should show debater" do
    get :show, id: @debater
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @debater
    assert_response :success
  end

  test "should update debater" do
    patch :update, id: @debater, debater: { record: @debater.record, user_id: @debater.user_id }
    assert_redirected_to debater_path(assigns(:debater))
  end

  test "should destroy debater" do
    assert_difference('Debater.count', -1) do
      delete :destroy, id: @debater
    end

    assert_redirected_to debaters_path
  end
end
