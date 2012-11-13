require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  def login
    session[:login] = @user
  end

  setup do
    @user = users(:one)
    login
  end

  test "should create comment" do
    assert_difference('Comment.count') do
      post :create, event_id: events(:one).id, comment: { content: "test" }
    end

    assert_redirected_to event_path(events(:one).id)
  end

  test "should get edit" do
    get :edit, event_id: events(:one).id, id: comments(:one).id
    assert_response :success
  end

  test "should update comment" do
    put :update, id: comments(:one).id, event_id: events(:one).id, comment: { content: "test" }
    assert_redirected_to event_path(events(:one).id)
  end

  test "should destroy comment" do
    assert_difference('Comment.count', -1) do
      delete :destroy, id: comments(:one).id, event_id: events(:one).id
    end

    assert_redirected_to event_path(events(:one).id)
  end
end
