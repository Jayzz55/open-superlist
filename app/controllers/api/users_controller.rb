 module API 
  class UsersController < ApiController

    def show
      user = User.find(params[:id])
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
      if user.update(user_params)
        render json: user, status: 200, root: false
      else
        render json: user.errors, status: 422
      end
    end

    def destroy
      user = User.find(params[:id])
      user.destroy
      head 204
    end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

  end
end