module API 
  class UsersController < ApiController
    respond_to :json

    before_action :authorize_user, only: [:show, :update, :destroy]
    before_action :authenticate_with_token!, only: [:show, :update, :destroy]

    def show
      render json: current_user, status: :ok, root: false
    end

    def create
      new_user = User.new(user_params)

      if new_user.save
        render json: new_user, status: :created, root: false
      else
        render json: new_user.errors, status: :unprocessable_entity
      end
    end

    def update
      if current_user.update(user_params)
        render json: current_user, status: :ok, root: false
      else
        render json: current_user.errors, status: :unprocessable_entity
      end
    end

    def destroy
      current_user.destroy
      head 204
    end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def authorize_user
      check_user = User.friendly.find(params[:id])
      authorize check_user
    end

  end
end