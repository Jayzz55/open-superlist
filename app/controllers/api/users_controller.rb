 module API 
  class UsersController < ApiController
    respond_to :json

    before_action :authenticate_with_token!, only: [:show, :update, :destroy]

    def show
      user = User.find(params[:id])
      authorize user
      render json: user, status: 200, root: false
    end

    def create
      new_user = User.new(user_params)

      if new_user.save
        render json: new_user, status: 201, root: false
      else
        render json: new_user.errors, status: 422
      end
    end

    def update
      user = User.find(params[:id])
      authorize user
      if user.update(user_params)
        render json: user, status: 200, root: false
      else
        render json: user.errors, status: 422
      end
    end

    def destroy
      user = User.find(params[:id])
      authorize user
      user.destroy
      head 204
    end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

  end
end