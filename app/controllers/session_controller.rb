class SessionController < ApplicationController
  def login
    @user = User.new
  end

  def create
    @user = User.find_by_email_and_password(params[:user][:email], params[:user][:password])

    if @user
      store_user @user

      redirect_to new_bottle_path
    else
      redirect_to session_login_path, notice: 'failure'
    end
  end
end
