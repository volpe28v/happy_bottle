class BottlesController < ApplicationController
  before_action :login_required
  before_action :activated_required

  def new
    @bottle = Bottle.new
    @partner = current_user.partner
    @key_words = current_user.partner.bottles.delivered.analize_words
  end

  def create
    begin
      @bottle = current_user.create_bottle(bottle_params)
    rescue
      redirect_to new_bottle_path, alert: 'メッセージが入力されていません！'
      return
    end

    redirect_to new_bottle_path, notice: '幸せが詰まった瓶を流しました！'
  end

  def tag
    @bottles = current_user.partner.bottles.delivered.find_by_tag(URI.decode(params[:tag])).order('created_at DESC')
  end

  private

  def bottle_params
    params.require(:bottle).permit(:message)
  end

  def activated_required
    redirect_to setting_user_path(current_user) unless current_user.activated?
  end
end
