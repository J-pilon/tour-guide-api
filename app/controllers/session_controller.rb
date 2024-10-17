class SessionController < ApplicationController
  skip_before_action :authenticate_user!, only: :create

  def create
    user = User.find_by(email: session_params[:email])
    if user && user.authenticate(session_params[:password])
      user.generate_auth_token
      if user.save
        render json: { status: 'success', message: 'User logged in', data: user }, status: :ok
      else
        render json: { status: 'error', message: 'User not logged in', data: user.errors }, status: :unprocessable_entity
      end
    else
      render json: { status: 'error', message: 'User not logged in', data: nil }, status: :unauthorized
    end
  end

  def destroy
    @current_user.authenication_token = nil
    @current_user.authentication_token_expiry = nil
    if @current_user.save
      render json: { status: 'success', message: 'User logged out', data: nil }, status: :ok
    else
      render json: { status: 'error', message: 'User not logged out', data: @current_user.errors }, status: :unprocessable_entity
    end
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
