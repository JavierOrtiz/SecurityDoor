module Api
  class AuthsController < Api::ApplicationController
    skip_before_action :authenticate, only: [:login, :register]
    def login
      @user = User.find_by_email(params[:email])
      if @user&.valid_password?(params[:password])
        token = ::JsonWebToken.encode({ user_id: @user.id, email: @user.email })
        render json: { user: @user, token: token }
      else
        render json: {error: "Invalid email or password" }, status: :unauthorized
      end
    end

    def register
      @user = User.new(registration_params)
      if @user.save
        token = ::JsonWebToken.encode({ user_id: @user.id, email: @user.email })
        render json: { token: token }
      else
        render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def registration_params
      params.require(:user).permit(:email, :password, :password_confirmation, :full_name, :phone)
    end
  end
end
