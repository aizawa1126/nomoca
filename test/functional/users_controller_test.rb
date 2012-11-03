require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def login
    session[:login] = @user
  end

  setup do
    @user = users(:one)
    login
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { account: "test", name: "test", password: "test", password_confirmation: "test" }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    put :update, id: @user, user: { account: "test", name: "test", password: "test", password_confirmation: "test" }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to root_path
  end
end
