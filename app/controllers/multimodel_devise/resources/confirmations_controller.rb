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
      render json: resource, status: :ok
    else
      respond_with_error(resource)
    end
  end
  
  protected
  
  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
  
  
  def respond_with_error(record)
    render json:   ::ErrorReport.generate(record.errors, 422),
           status: :unprocessable_entity
  end


end
