class MultimodelDevise::Resources::ConfirmationsController < Devise::ConfirmationsController

  #We need to accept html too since we're sending the raw api link in the emails.
  #We could ofc. have the link point to somewhere on the frontend that would then
  #do a JSON request on the api path and then we would just respond with simple JSON
  #response saying ok, error, already confirmed etc. instead of silly redirects...
  #However, this is the way it's working right now..

  # respond_to :html, :json
  #
  # before_action -> { I18n.locale = 'fi' }
  # skip_before_filter :require_no_authentication
  # skip_before_filter :authenticate_user!

  # GET /resource/confirmation/new
  # def new
  #   super
  # end

  # POST /resource/confirmation
  # def create
  #   super
  # end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show

    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?

    if resource and resource.errors.empty?
      redirect_to after_confirmation_path_for(resource_name, resource)
    else
      redirect_to after_failed_confirmation_path_for(resource_name, resource)
    end
  end

  protected

  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  def after_failed_confirmation_path_for(resource_name, resource)
    if Rails.configuration.respond_to?(:confirmation_urls)
      if resource.confirmation_token.blank? && resource.confirmed?
        Rails.configuration.confirmation_urls[resource_name]["already_confirmed"]
      else
        Rails.configuration.confirmation_urls[resource_name]["confirmation_error"]
      end
    else
      #In future report this kind of case to System Admin via email
      'http://'+request.host+':'+request.port.to_s
    end
  end

  # The path used after confirmation.
  def after_confirmation_path_for(resource_name, resource)
    if Rails.configuration.respond_to?(:confirmation_urls)
      Rails.configuration.confirmation_urls[resource_name]["confirmation_succeeded"]
    else
      #In future report this kind of case to System Admin via email
      'http://'+request.host+':'+request.port.to_s
    end
  end
end
