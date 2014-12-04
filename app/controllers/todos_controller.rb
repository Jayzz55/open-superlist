class TodosController < ApplicationController
  respond_to :html, :js

  before_action :authenticate_user!
  
  def index
    @user = current_user
    @todos = @user.todos  
    @new_todo = Todo.new
    authorize @user
  end

  #this actioin is disabled, since the destroy function is done via api
  # def create
  #   @todo = current_user.todos.build(todo_params)
  #   authorize @todo


  #   if @todo.save
  #     flash[:notice] = "Todo was saved."
  #   else
  #     flash[:error] = "There was an error saving the todo item. Please try again."
  #   end

  #   respond_with(@todo) do |format|
  #     format.html { redirect_to todos_path }
  #   end
  # end

  #this actioin is disabled, since the destroy function is done via api
  # def destroy
  #   @todo = current_user.todos.find(params[:id])
  #   authorize @todo

  #   if @todo.destroy
  #     flash[:notice] = "Todo item was removed."
  #   else
  #     flash[:error] = "Todo item couldn't be deleted. Try again."
  #   end

  #   respond_with(@todo) do |format|
  #     format.html { redirect_to todos_path }
  #   end
  # end

  def destroy_multiple

    ids = params[:todos]
    
    if ids.present?
      if current_user.todos.where(id: ids).destroy_all
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