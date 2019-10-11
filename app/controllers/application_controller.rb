class ApplicationController < ActionController::Base
  # after_action :store_action
  protect_from_forgery with: :exception
  before_action :set_locale
  around_action :switch_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
 
  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end
  
  def default_url_options(options = {})
     { :locale => I18n.locale }.merge options
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || home_setboxes_path
  end  

  # def store_action
  #   return unless request.get? 
  #   if (request.path != "/users/sign_in" &&
  #       request.path != "/users/sign_up" &&
  #       request.path != "/users/password/new" &&
  #       request.path != "/users/password/edit" &&
  #       request.path != "/users/confirmation" &&
  #       request.path != "/users/sign_out" &&
  #       !request.xhr?) # don't store ajax calls
  #     store_location_for(:user, request.fullpath)
  #   end
  # end
end
