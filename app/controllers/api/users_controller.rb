class Api::UsersController < ApplicationController
  def index
    if user_signed_in?
      @users = User.all
    else
      @users = User.all
    end
    #render :json => user
  end
  def show
    if user_signed_in?
      @user = current_user
    else
      @user.admin = false 
    end
  end
end
