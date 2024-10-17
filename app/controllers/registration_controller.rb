class RegistrationController < ApplicationController
  skip_before_action :authenticate_user!, only: :create

  def create
    user = User.new(registration_params)
    user.generate_auth_token
    if user.save
      render json: { status: 'success', message: 'User created', data: user }, status: :created
    else
      render json: { status: 'error', message: 'User not created', data: user.errors }, status: :unprocessable_entity
    end
  end

  private

  def registration_params
    params.require(:registration).permit(:email, :password, :password_confirmation)
  end

  def generate_auth_token
    SecureRandom.hex(10)
  end
end
