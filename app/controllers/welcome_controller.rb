class WelcomeController < ApplicationController
  before_action :reject_if_login

  def index
  end

  private

  def reject_if_login
    redirect_to new_bottle_path if current_user
  end
end
