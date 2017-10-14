class MultimodelDevise::Resources::SessionsController < Devise::SessionsController
  
  # before_filter :configure_sign_in_params, only: [:create]
  # skip_before_action :verify_authenticity_token
  respond_to "json"
  
  # POST /resource/sign_in
  def create
    @resource = resource_class.where(email: session_params[:email]).first
    if @resource.present? && @resource.valid_password?(session_params[:password])
      @resource.update_auth_token
      setup_headers(@resource)
      render json: @resource, root: 'user', serializer: MultimodelDevise::UserSerializer, status: :ok
    else
      authentication_error
    end
  end
  
  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end
  
  protected
  
  # You can put the params you want to permit in the empty array.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
  def session_params
    params.permit(:email, :password)
  end
  
  def authentication_error
    render json:  MultimodelDevise::ErrorReport.generate({ authentication: [t(".auth_fail")] }, 401), status: :unauthorized, root: false
  end
  
  def deactivated_error(status)
    MultimodelDevise::ErrorReport.generate({ authentication: [t(".deactivated")] }, status)
  end
  
  def setup_headers(resource)
    auth                             = resource.auth_token
    response.headers['access-token'] = auth.authentication_token
    response.headers['client']       = resource.id
    response.headers['uid']          = auth.id
    response.headers['token-type']   = "Bearer" #TODO: this can come from db later.
    response.headers['expiry']       = auth.expiry_date
  end
end
