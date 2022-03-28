class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    protect_from_forgery
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:admin])
    end
    def  to_sign_page
        unless user_signed_in?
            #サインインしていないユーザーはログインページが表示される
            redirect_to  new_user_session_path
        end
    end
end
