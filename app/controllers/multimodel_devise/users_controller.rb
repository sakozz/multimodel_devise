class MultimodelDevise::UsersController < MultimodelDevise::ApplicationController
  include MultimodelDevise::Concerns::Authentication
  after_action :verify_policy_scoped, :only => :index

  # GET /v1/users
  def index
    @users = policy_scope(MultimodelDevise::User)
    render json: @users, each_serializer: MultimodelDevise::UserSerializer, root: 'users'
  end

  # GET /v1/users/1
  def show
    @user = MultimodelDevise::User.find(params[:id])
    authorize(@user)
    render json: @user, serializer: MultimodelDevise::UserSerializer, root: 'user'
  end

  # PATCH/PUT /v1/users/1
  def update
    authorize(@user = MultimodelDevise::User.find(params[:id]))
    if @user.update_attributes update_params
      render json: @user, serializer: MultimodelDevise::UserSerializer, status: :ok
    else
      render json: failure(@user), status: :unprocessable_entity
    end
  end

  def failure(resource)
    { success: false, errors: resource.errors }
  end

  def update_params
    params.require(:user).permit(
        :email, :first_name, :last_name
    )
  end

end
