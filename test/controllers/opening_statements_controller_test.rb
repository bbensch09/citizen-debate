require 'test_helper'

class OpeningStatementsControllerTest < ActionController::TestCase
  setup do
    @opening_statement = opening_statements(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:opening_statements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create opening_statement" do
    assert_difference('OpeningStatement.count') do
      post :create, opening_statement: { author_id: @opening_statement.author_id, content: @opening_statement.content, debate_id: @opening_statement.debate_id, round_id: @opening_statement.round_id, unread: @opening_statement.unread }
    end

    assert_redirected_to opening_statement_path(assigns(:opening_statement))
  end

  test "should show opening_statement" do
    get :show, id: @opening_statement
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @opening_statement
    assert_response :success
  end

  test "should update opening_statement" do
    patch :update, id: @opening_statement, opening_statement: { author_id: @opening_statement.author_id, content: @opening_statement.content, debate_id: @opening_statement.debate_id, round_id: @opening_statement.round_id, unread: @opening_statement.unread }
    assert_redirected_to opening_statement_path(assigns(:opening_statement))
  end

  test "should destroy opening_statement" do
    assert_difference('OpeningStatement.count', -1) do
      delete :destroy, id: @opening_statement
    end

    assert_redirected_to opening_statements_path
  end
end
