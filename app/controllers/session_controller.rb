class SessionController < ApplicationController
  def login
    @user = User.new
  end

  def create
    # TODO ログイン処理をする
    @user = User.find_by_email_and_password(params[:user][:email], params[:user][:password])

    if @user
      # TODO 成功画面へ遷移する 
      redirect_to session_login_path, notice: 'success'
    else
      redirect_to session_login_path, notice: 'failure'
    end
  end
end
