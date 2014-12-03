module API
  class TodosController < ApiController

    before_action :authenticate_user

    def index
      todos = Todo.all
      render json: todos, status: 200, root: false

    end

    def show
      todo = Todo.find(params[:id])
      render json: todo, status: 200, root: false
    end

    def create
      new_todo = Todo.new(todo_params)

      if new_todo.save
        render json: new_todo, status: 201, root: false
      else
        render json: new_todo.errors, status: 422
      end
    end

    def update
      todo = Todo.find(params[:id])
      if todo.update(todo_params)
        render json: todo, status: 200
      else
        render json: todo.errors, status: 422
      end
    end

    def destroy
      todo = Todo.find(params[:id])
      todo.destroy
      head 204
    end

    private

    def todo_params
      params.require(:todo).permit(:body, :user_id)
    end

    def authenticate_user
      user = User.find(params[:user_id])
      authorize user
    end

  end
end