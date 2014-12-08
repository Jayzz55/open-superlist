class TodosController < ApplicationController
  respond_to :html

  before_action :authenticate_user!
  
  def index
    @user = current_user
    @todos = @user.todos  
    authorize @user
  end

end