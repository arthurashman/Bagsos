# frozen_string_literal: true

class TasksController < ApplicationController
  def index
    if current_user.user_type == "volunteer"
      @tasks = Task.order("created_at DESC")
    else
      redirect_to "/tasks/new"
    end
  end

  def new
    if current_user.user_type == "beneficiary"
      @task = Task.new
    else
      redirect_to "/tasks"
    end
  end

  def create
    @task = Task.create(task_params.merge(user_id: current_user.id))

    if @task.valid?
      redirect_to "/users/#{current_user.id}"
      flash[:success] = 'Task successfully listed'
    else
      redirect_to "/tasks/new"
      flash[:danger] = @task.errors.full_messages.join("<br>")
    end
  end

  def show
    @task = Task.find(params[:id])
  end
  
  def edit
    @task = Task.find(params[:id])
    if @task.user_id != current_user.id
      flash[:danger] = "You can't edit that task!"
      redirect_to "/users/#{current_user.id}"
    end
  end

  def destroy
      task = Task.find(params[:id])
      task.destroy
      flash[:success] = "Task has been deleted"

      redirect_to "/users/#{current_user.id}"
  end

  private

  def task_params
    params.require(:task).permit(:id, :title, :description, :address, :latitude, :longitude)
  end
end
