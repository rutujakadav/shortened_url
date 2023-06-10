# frozen_string_literal: true
require 'jwt'
class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :generate_jwt_token, only: [:new, :create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    generate_jwt_token
    super
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  private 

  def generate_jwt_token
    user = User.find_by_email(params["user"]["email"]) if !params.nil? && params.key?("user") && params["user"].key?("email")
    return unless user.present?
    payload = {id: user.id, exp: Time.now.to_i + 24*3600}
    session[:jwt_token] = JWT.encode payload, Config.find_by_name("hmac_secret").value, 'HS256'
  end
end
