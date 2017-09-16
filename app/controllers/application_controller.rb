class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  respond_to :json

  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    head :forbidden
  end
end
