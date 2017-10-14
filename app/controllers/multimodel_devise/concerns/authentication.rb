module MultimodelDevise::Concerns
  module Authentication
    extend ActiveSupport::Concern
    included do
      before_action :authenticate_with_token!
    end

    # This is our new function that we gonna hack into the Devise's own function
    def authenticate_with_token!
      #Use authentication token and email from request header
      authenticate_or_request_with_http_token do |token, options|
        options = params[:user] if options.blank? && params[:user]
        
        #https://gist.github.com/josevalim/fb706b1e933ef01e4fb6#comment-1331298
        id = options[:identifier]

        token_record = id && ::MultimodelDevise::AuthToken.find(id)
        resource = token_record.token_authenticable

        #  Use Devise.secure_compare to compare the token in the database with the token given in the params, mitigating timing attacks.
        if resource && token_record.token_valid? && Devise.secure_compare(token_record.authentication_token, token.split('"').last)
          sign_in(:user, resource, store: false)
        end
      end
    end
  end
end