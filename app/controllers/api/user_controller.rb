class Api::UserController < ApplicationController
  def index
    if user_signed_in?
      user = {'admin' => true} if current_user.id == 1
    else
      user = {'admin' => false}
    end
    render :json => user
  end
end
