class Api::UsersController < ApplicationController
  def index
    
  end
  def show
    if user_signed_in?
      @user = current_user
    end
  end
end
