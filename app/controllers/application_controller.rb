class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller? 
    layout :layout_by_resource
 
    protected
    def layout_by_resource
        return "layouts/session" if devise_controller?
    
        "layouts/application"
    end
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
        devise_parameter_sanitizer.permit(:account_update, keys: [:name])
      end
end
