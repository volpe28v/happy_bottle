class BottlesController < ApplicationController
  before_action :login_required

  def new
    @bottle = Bottle.new
    @key_words = current_user.partner.bottles.analize_words
  end

  def create
    @bottle = current_user.create_bottle(bottle_params)

    redirect_to new_bottle_path, notice: '流したよー'
  end

  private

  def bottle_params
    params.require(:bottle).permit(:message)
  end
end
