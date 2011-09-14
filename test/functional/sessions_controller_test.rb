require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "sign in user with valid credentials" do
    auth_info = {'uid' => "1234", 'user_info' => {'nickname' => 'guille'},
                 'credentials' => {'token' => '70k3n', 'secret' => 's3cr37'}}
    @request.env["omniauth.auth"] = auth_info
    get :create, :provider => "twitter"

    assert flash[:notice]
    assert_redirected_to edit_user_path(assigns(:user))
  end

  test "don't sign in user with invalid credentials" do
    get :create, :provider => "twitter"

    assert flash[:alert]
    assert_redirected_to root_path
  end

  test "sign out user" do
    get :destroy

    assert_nil session[:user_id]
    assert flash[:notice]
    assert_redirected_to root_path
  end
end
