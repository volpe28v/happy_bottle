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

      InvitationMailer.invite(partner, @user).deliver
    end

    store_user @user

    redirect_to new_bottle_path
  end

  def verify
    @user = User.find_by_invitation_token(params[:invitation_token])
    @user.verify!

    redirect_to setting_user_path(@user)
  end

  def setting
    # TODO password が nil だと、必ず setting に飛ばすようにしたい
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
