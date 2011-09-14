class UsersController < InheritedResources::Base
  respond_to :html
  before_filter :authenticate!, :except => :new
  after_filter Proc.new { session[:user_id] = nil }, :only => :destroy

  def update
    update!(:notice => 'Twitter account is now associated for translations!'){ edit_user_path(@user) }
  end

  def destroy
    destroy!(:notice => 'Twitter account de-associated'){ root_path }
  end

  protected
  def resource
    @user = current_user
  end
end
