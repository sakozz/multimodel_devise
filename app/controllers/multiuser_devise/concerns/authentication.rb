module MultiuserDevise::Concerns
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
        #TODO: There could possibly be other means to identify your self as well.
        #TODO: In fact I consider using email here as unsafe too, so you shouldn't do that:
        #https://gist.github.com/josevalim/fb706b1e933ef01e4fb6#comment-1331298
        id = options[:identifier]

        # resource = params[:role] == 'Admin' ? MultiuserDevise::AdminUser : MultiuserDevise::User
        token_record = id && ::MultiuserDevise::AuthToken.find(id)
        resource = token_record.token_authenticable

        # Notice how we use Devise.secure_compare to compare the token
        # in the database with the token given in the params, mitigating
        # timing attacks.
        if resource && Devise.secure_compare(token_record.authentication_token, token.split('"').last)
          sign_in(:user, resource, store: false)
        end
      end
    end
  end
end