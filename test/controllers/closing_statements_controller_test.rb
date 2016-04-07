require 'test_helper'

class ClosingStatementsControllerTest < ActionController::TestCase
  setup do
    @closing_statement = closing_statements(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:closing_statements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create closing_statement" do
    assert_difference('ClosingStatement.count') do
      post :create, closing_statement: { author_id: @closing_statement.author_id, content: @closing_statement.content, debate_id: @closing_statement.debate_id, round_id: @closing_statement.round_id, unread: @closing_statement.unread }
    end

    assert_redirected_to closing_statement_path(assigns(:closing_statement))
  end

  test "should show closing_statement" do
    get :show, id: @closing_statement
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @closing_statement
    assert_response :success
  end

  test "should update closing_statement" do
    patch :update, id: @closing_statement, closing_statement: { author_id: @closing_statement.author_id, content: @closing_statement.content, debate_id: @closing_statement.debate_id, round_id: @closing_statement.round_id, unread: @closing_statement.unread }
    assert_redirected_to closing_statement_path(assigns(:closing_statement))
  end

  test "should destroy closing_statement" do
    assert_difference('ClosingStatement.count', -1) do
      delete :destroy, id: @closing_statement
    end

    assert_redirected_to closing_statements_path
  end
end
