require 'test_helper'

class InvitationsControllerTest < ActionController::TestCase
  def login
    session[:login] = @user
  end

  setup do
    @user = users(:one)
    @event = events(:one)
    @invitation = invitations(:one)
    login
  end

  test "should get new" do
    get :new, event_id: @event.id
    assert_response :success
  end

  test "should create invitation" do
    assert_difference('Invitation.count') do
      post :create, event_id: @invitation.event_id, invitation: { event_id: @invitation.event_id, intention: @invitation.intention, owner_id: @invitation.owner_id, user_id: '999' }
    end

    assert_redirected_to '/events/1'
  end

  test "should get edit" do
    get :edit, id: @invitation, event_id: @invitation.event_id
    assert_response :success
  end

  test "should update invitation" do
    put :update, id: @invitation, event_id: @invitation.event_id, invitation: { event_id: @invitation.event_id, intention: @invitation.intention, owner_id: @invitation.owner_id, user_id: @invitation.user_id }
    assert_redirected_to event_path
  end

  test "should destroy invitation" do
    assert_difference('Invitation.count', -1) do
      delete :destroy, id: @invitation, event_id: @invitation.event_id
    end

    assert_redirected_to '/events/1'
  end
end
