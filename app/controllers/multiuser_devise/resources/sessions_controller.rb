class MultiuserDevise::Resources::SessionsController < Devise::SessionsController

  # before_filter :configure_sign_in_params, only: [:create]
  # skip_before_action :verify_authenticity_token
  respond_to "json"

  # POST /resource/sign_in
  def create
    @resource = resource_class.where(email: session_params[:email]).first
    if @resource.present? && @resource.valid_password?(session_params[:password])
      @resource.update_auth_token
      render json: @resource, root: 'user', serializer: MultiuserDevise::SessionSerializer, status: :ok
    else
      render json: authentication_error(401), status: :unauthorized, root: false
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

  def authentication_error(status)
    MultiuserDevise::ErrorReport.generate({authentication: [t(".auth_fail")]}, status)
  end

  def deactivated_error(status)
    MultiuserDevise::ErrorReport.generate({authentication: [t(".deactivated")]}, status)
  end

end
