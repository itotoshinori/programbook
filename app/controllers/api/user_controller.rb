class Api::UserController < ApplicationController
  def index
    if user_signed_in?
      user = {'login' => true}
    else
      user = {'login' => false}
    end
    render :json => user
  end
end
