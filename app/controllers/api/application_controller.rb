module Api
  class ApplicationController < ActionController::API
    include ActionController::HttpAuthentication::Token::ControllerMethods

    rescue_from ActiveRecord::RecordNotFound do
      head :not_found
    end

    before_action :authenticate

    private

    def authenticate
      authenticate_token || render_unauthorized
    end

    def authenticate_token
      authenticate_with_http_token do |token, options|
        begin
          user_decoded = JsonWebToken.decode(token)
          @current_user = User.find(user_decoded[:user_id])
        rescue ActiveRecord::RecordNotFound => e
          render json: { errors: e.message }, status: :unauthorized
        rescue JWT::DecodeError => e
          render json: { errors: e.message }, status: :unauthorized
        end
      end
    end

    def render_unauthorized
      render json: 'Bad credentials', status: 401
    end
  end
end
