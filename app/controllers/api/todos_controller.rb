module API
  class TodosController < ApiController

    before_action :authorize_user
    before_action :authenticate_with_token!

    def index
      todos = current_user.todos
      render json: todos, status: :ok, root: false

    end

    def create
      new_todo = current_user.todos.build(todo_params)

      if new_todo.save
        render json: new_todo, status: :created, root: false
      else
        render json: new_todo.errors, status: :unprocessable_entity
      end
    end

    def update
      todo = current_user.todos.find(params[:id])
      if todo.update(todo_params)
        render json: todo, status: :ok
      else
        render json: todo.errors, status: :unprocessable_entity
      end
    end

    def destroy
      todo = current_user.todos.find(params[:id])
      todo.destroy
      head 204
    end

    def destroy_multiple

    ids = params[:todos]
    selected_todos = current_user.todos.where(id: ids)
    
      if selected_todos.destroy_all
        head 204
      else
        render json: selected_todos.errors, status: :unprocessable_entity
      end

    end

    private

    def todo_params
      params.require(:todo).permit(:body, :user_id)
    end

    def authorize_user
      check_user = User.friendly.find(params[:user_id])
      authorize check_user
    end

  end
end