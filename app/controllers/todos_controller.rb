class TodosController < ApplicationController
  respond_to :html, :js
  def index
    @user = current_user
    @todos = @user.todos  
    @new_todo = @user.todos.build
    authorize @user
  end

  def create
    @todo = current_user.todos.build(todo_params)
    @new_todo = current_user.todos.build
    authorize @todo


    if @todo.save
      flash[:notice] = "Todo was saved."
    else
      flash[:error] = "There was an error saving the todo item. Please try again."
    end

    respond_with(@todo) do |format|
      format.html { redirect_to todos_path }
    end

  end

  def destroy
    @todo = current_user.todos.find(params[:id])
    authorize @todo

    if @todo.destroy
      flash[:notice] = "Todo item was removed."
    else
      flash[:error] = "Todo item couldn't be deleted. Try again."
    end

    respond_with(@todo) do |format|
      format.html { redirect_to todos_path }
    end

   end

  def destroy_multiple
    @todos = Todo.current_user_match(current_user)
    @checked_todos = Todo.checkbox_checked(params[:todos])

    if @checked_todos.first != nil
      if @todos.destroy(params[:todos])
        flash[:notice] = "Completed todo items were removed."
        redirect_to todos_path
      else
        flash[:error] = "Completed todo items couldn't be deleted. Try again."
        redirect_to todos_path
      end
    else
      flash[:error] = "Please make sure to mark the completed todo item"
      redirect_to todos_path
    end

  end

  private

  def todo_params
    params.require(:todo).permit(:body)
  end

end