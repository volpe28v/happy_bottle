class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    User.transaction do
      @user = User.create!(user_params)
      @user.partnership = Partnership.create!
      @user.save!

      InvitationMailer.invite(params[:invitation], @user)
    end

    store_user @user

    redirect_to new_bottle_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
