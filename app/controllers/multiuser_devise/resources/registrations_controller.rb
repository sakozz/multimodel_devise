class MultiuserDevise::Resources::RegistrationsController < Devise::RegistrationsController

  # before_action -> { I18n.locale = 'fi' }
  before_action :configure_sign_up_params, only: [:create]
  # before_filter :configure_account_update_params, only: [:update]
  # skip_before_action :verify_authenticity_token, only: [:create]

  after_action :verify_authorized #enforces pundit for every action

  # POST /resource
  def create
    @resource = resource_class.new(sign_up_params)
    authorize(@resource)
    if @resource.save
      render json: @resource.auth_token, serializer: MultiuserDevise::AuthTokenSerializer, status: :created
    else
      render json: failure(@resource, 422), status: :unprocessable_entity
    end
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # You can put the params you want to permit in the empty array.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:email, :password, :password_confirmation)
    end
  end

  def failure(resource, status)
    MultiuserDevise::ErrorReport.generate(resource.errors, status)
  end

  # You can put the params you want to permit in the empty array.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

end
