class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)

    store_user @user

    redirect_to new_bottle_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
