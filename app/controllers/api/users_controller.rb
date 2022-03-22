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
    @user = User.find(params[:id])
    if user_signed_in?
      
    else
      @user.admin = false 
    end
  end
end
