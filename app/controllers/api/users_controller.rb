class Api::UsersController < ApplicationController
    def index
        render json: { user_admin: true }
    end
end
