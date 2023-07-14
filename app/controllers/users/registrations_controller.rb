# frozen_string_literal: true
include ActionController::Flash 
class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  protected

  #If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  end

  #If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  end

  #The path used after sign up.
  def after_sign_up_path_for(resource)
    super(resource)
  end

  #The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    super(resource)
  end

  # Devise::RegistrationsController
  respond_to :json
  private
  def respond_with(resource, _opts = {})
    resource.persisted? ? register_success : register_failed(resource) 
  end
  def register_success
    render json: { message: 'Signed up.' }
  end
  def register_failed(resource)
    render json: { message: resource.errors.full_messages }
  end
end
