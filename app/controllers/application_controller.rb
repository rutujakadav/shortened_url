class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    skip_before_action :verify_authenticity_token
    
    private 
    def authenticate
        if request.headers['Authorization'].present?
            begin
                decoded_token = JWT.decode request.headers['Authorization'], Config.find_by_name("hmac_secret").value, true, { algorithm: 'HS256' }
                render json: {error: true,  message: 'Invalid credentials'} unless User.find_by_id(decoded_token[0]['id']).present?
            rescue Exception => e
                render json: {error: true,  message: e.to_s}
            end
        else
            render json: {error: true,  message: 'Invalid credentials'}
        end
    end
end
