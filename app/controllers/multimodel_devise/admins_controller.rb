class MultimodelDevise::AdminsController < MultimodelDevise::ApplicationController
  include MultimodelDevise::Concerns::Authentication

  after_action :verify_policy_scoped, :only => :index

  # GET /v1/admins
  def index
    @admins = policy_scope(MultimodelDevise::Admin)
    render json: @admins, each_serializer: MultimodelDevise::AdminSerializer, root: 'admins'
  end

  # GET /v1/admins/1
  def show
    @admin = MultimodelDevise::Admin.find(params[:id])
    authorize(@admin)
    render json: @admin, serializer: MultimodelDevise::AdminSerializer, root: 'admin'
  end

  # PATCH/PUT /v1/admins/1
  def update
    authorize(@admin = MultimodelDevise::Admin.find(params[:id]))
    if @admin.update_attributes update_params
      render json: @admin, serializer: MultimodelDevise::AdminSerializer, status: :ok
    else
      render json: failure(@admin), status: :unprocessable_entity
    end
  end

  def failure(resource)
    { success: false, errors: resource.errors }
  end

  def update_params
    params.require(:admin).permit(
        :email, :first_name, :last_name
    )
  end

end
