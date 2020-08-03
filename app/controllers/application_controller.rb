class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :for_image_search

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:email,:password,:password_confirmation])
    end

    def for_image_search
      @image_search = PlaceImage.new
    end

end
