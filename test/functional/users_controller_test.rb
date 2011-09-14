require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = User.create(:translated => "guille", :translated_uid => "12345",
                        :token => 'token', :secret => 'secret')
  end

  test "render new user page" do
    session[:user_id] = nil
    get :new

    assert_nil session[:user_id]
    assert_response :success
    assert_template :new
  end

  test "render edit user page" do
    @request.session[:user_id] = @user.id
    get :edit, :id => @user.id

    assert_not_nil assigns(:user)
    assert_response :success
    assert_template :edit
  end

  test "update existing user" do
    @request.session[:user_id] = @user.id
    attrs = {:original => 'test', :original_uid => '1235', :lang_from => 'en', :lang_to => 'es'}
    put :update, :id => @user.id, :user => attrs

    assert_not_nil assigns(:user)
    assert_redirected_to edit_user_path(@user)
  end

  test "delete a existing user" do
    @request.session[:user_id] = @user.id
    delete :destroy, :id => @user.id

    assert_nil session[:user_id]
    assert_redirected_to root_path
  end
end
