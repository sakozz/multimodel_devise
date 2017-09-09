class MultimodelDevise::Resources::PasswordsController < Devise::PasswordsController

  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      render json: {success: true, message: 'Password reset instruction sent.'}, status: :ok
    else
      render json: failure(resource, 406), status: :not_acceptable
    end
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  def update
    if resource_params[:password].present? &&
        resource_params[:password_confirmation].present? &&
        resource_params[:password] == resource_params[:password_confirmation]

      self.resource = resource_class.reset_password_by_token(resource_params)
      yield resource if block_given?

      if resource.errors.empty?
        resource.unlock_access! if unlockable?(resource)
        render json: {message: I18n.t('devise.passwords.updated'), success: true}, status: :ok
      else
        render json: failure(resource, 406), status: :not_acceptable
      end
    else
      render json: password_error(406), status: :not_acceptable
    end
  end

  protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  def failure(resource, status)
    MultimodelDevise::ErrorReport.generate(resource.errors, status)
  end

  def password_error(status)
    MultimodelDevise::ErrorReport.generate({password: [t(".password_empty_or_not_matched")]}, status)
  end
end
