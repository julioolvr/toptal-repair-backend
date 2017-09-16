class ApplicationController < ActionController::API
  respond_to :json

  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    head :forbidden
  end
end
