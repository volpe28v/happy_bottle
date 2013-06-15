class BottlesController < ApplicationController
  def new
    @bottle = Bottle.new
  end

  def create
  end
end
