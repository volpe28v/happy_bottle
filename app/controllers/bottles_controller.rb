class BottlesController < ApplicationController
  before_action :login_required

  def new
    @bottle = Bottle.new

    # TODO パートナーが未登録の場合の処理を考える
    if current_user.partner
      @key_words = current_user.partner.bottles.analize_words
    else
      @key_words = []
    end
  end

  def create
    @bottle = current_user.create_bottle(bottle_params)

    redirect_to new_bottle_path, notice: '流したよー'
  end

  def tag
    @bottles = current_user.partner.bottles.find_by_tag(URI.decode(params[:tag]))

  end

  private

  def bottle_params
    params.require(:bottle).permit(:message)
  end
end
