class ApplicationController < ActionController::API
  before_action :authenticate_user!
  respond_to :json

  def authenticate_user!
    authenticate_or_request_with_http_token do |token, _options|
      user = User.find_by(authentication_token: token)
      if user && ActiveSupport::SecurityUtils.secure_compare(token, user.authenication_token)
        @current_user = user
      else
        render json: { error: "Unauthorized" }, status: :unauthorized
      end
    end
  end
end
