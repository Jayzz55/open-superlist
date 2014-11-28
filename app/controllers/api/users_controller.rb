 module API 
  class UsersController < ApiController
    
    def index
      users = User.all
      render json: users, status: 200, root: false
    end

    def show
      user = User.find(params[:id])
      render json: user, status: 200, root: false
    end

  end
end