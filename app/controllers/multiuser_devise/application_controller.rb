module MultiuserDevise
  class ApplicationController < ActionController::Base
    # skip_before_action :verify_authenticity_token
    include Pundit

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    #rescue when pundit raises unauthorized error
    def user_not_authorized
      respond_to do |format|
        format.json do
          render json: ErrorReport.generate( { id: [t("errors.messages.not_authorized")] }, 403 ), status: :forbidden
        end
      end
    end

    protect_from_forgery with: :exception, unless: -> { request.format.json? }
    respond_to "json"

    protected

    def use_http_authentication?
      false
    end
  end
end
