require 'test_helper'

class TopicTagsControllerTest < ActionController::TestCase
  setup do
    @topic_tag = topic_tags(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:topic_tags)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create topic_tag" do
    assert_difference('TopicTag.count') do
      post :create, topic_tag: { debate_id: @topic_tag.debate_id, topic_id: @topic_tag.topic_id }
    end

    assert_redirected_to topic_tag_path(assigns(:topic_tag))
  end

  test "should show topic_tag" do
    get :show, id: @topic_tag
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @topic_tag
    assert_response :success
  end

  test "should update topic_tag" do
    patch :update, id: @topic_tag, topic_tag: { debate_id: @topic_tag.debate_id, topic_id: @topic_tag.topic_id }
    assert_redirected_to topic_tag_path(assigns(:topic_tag))
  end

  test "should destroy topic_tag" do
    assert_difference('TopicTag.count', -1) do
      delete :destroy, id: @topic_tag
    end

    assert_redirected_to topic_tags_path
  end
end
