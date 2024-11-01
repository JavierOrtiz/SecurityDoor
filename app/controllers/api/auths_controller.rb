module Api
  class AuthsController < Api::ApplicationController
    skip_before_action :authenticate, only: :login
    def login
      @user = User.find_by_email(params[:email])
      if @user&.valid_password?(params[:password])
        token = ::JsonWebToken.encode({ user_id: @user.id, email: @user.email })
        render json: { user: @user, token: token }
      else
        render json: {error: "Invalid email or password" }, status: :unauthorized
      end
    end
  end
end
