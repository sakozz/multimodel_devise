module MultiuserDevise
  class ApplicationController < ActionController::Base
    # skip_before_action :verify_authenticity_token
    protect_from_forgery with: :exception, unless: -> { request.format.json? }
    respond_to "json"

    protected

    def use_http_authentication?
      false
    end
  end
end
