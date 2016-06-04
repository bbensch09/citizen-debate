require 'test_helper'

class CharityEmailsControllerTest < ActionController::TestCase
  setup do
    @charity_email = charity_emails(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:charity_emails)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create charity_email" do
    assert_difference('CharityEmail.count') do
      post :create, charity_email: { email: @charity_email.email }
    end

    assert_redirected_to charity_email_path(assigns(:charity_email))
  end

  test "should show charity_email" do
    get :show, id: @charity_email
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @charity_email
    assert_response :success
  end

  test "should update charity_email" do
    patch :update, id: @charity_email, charity_email: { email: @charity_email.email }
    assert_redirected_to charity_email_path(assigns(:charity_email))
  end

  test "should destroy charity_email" do
    assert_difference('CharityEmail.count', -1) do
      delete :destroy, id: @charity_email
    end

    assert_redirected_to charity_emails_path
  end
end
