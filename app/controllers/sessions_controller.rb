class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    @user = User.authenticate(auth)
    respond_to do |format|
      if @user && @user.persisted?
        session[:user_id] = @user.id
        format.html { redirect_to edit_user_path(@user), :notice => "Signed in!" }
      else
        format.html { redirect_to root_url, :alert => "Error sign in" }
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
end
