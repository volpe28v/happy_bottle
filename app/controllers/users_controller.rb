class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    begin
      User.transaction do
        @user = User.new(user_params)
        @user.save!
        partnership = Partnership.create!
        @user.partnership = partnership
        @user.save!

        partner = User.create!(email: params[:invitation])
        partner.partnership = partnership
        partner.update_invitation_token
        partner.save!

        InvitationMailer.invite(partner, @user).deliver
      end

      store_user @user

      redirect_to new_bottle_path, notice: "#{params[:invitation]} 宛に招待メールを送信しました!"
    rescue => e
      self.logger.error ["#{e.class} #{e.message}:", *e.backtrace.map {|m| '  '+m }].join("\n")

      redirect_to new_user_path, alert: 'Email はすでに登録されています' # XXX 他にもありそう
    end
  end

  def update
    @user = User.find(params[:id])

    @user.update_attributes!(user_params)

    redirect_to new_bottle_path
  end

  def verify
    @user = User.find_by_invitation_token(params[:invitation_token])
    @user.verify!

    store_user @user

    redirect_to setting_user_path(@user)
  end

  def setting
    # TODO password が nil だと、必ず setting に飛ばすようにしたい
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
