class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    User.transaction do
      @user = User.create!(user_params)
      partnership = Partnership.create!
      @user.partnership = partnership
      @user.save!

      partner = User.create!(email: params[:invitation])
      partner.update_invitation_token
      partner.save!

      InvitationMailer.invite(partner, @user)
    end

    store_user @user

    redirect_to new_bottle_path
  end

  def verify
    # TODO Verify
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
