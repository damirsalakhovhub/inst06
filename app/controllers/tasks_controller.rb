class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = policy_scope(Task).where(project: @project)
  end

  def show
    authorize @task
  end

  def new
    @task = @project.tasks.build(creator: current_user)
    authorize @task
  end

  def create
    @task = @project.tasks.build(task_params)
    @task.creator = current_user
    authorize @task

    if @task.save
      redirect_to [@project, @task], notice: "Task was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @task
  end

  def update
    authorize @task
    if @task.update(task_params)
      redirect_to [@project, @task], notice: "Task was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @task
    @task.destroy
    redirect_to project_tasks_path(@project), notice: "Task was successfully deleted."
  end

  private

  def set_project
    @project = current_organization.projects.find(params[:project_id])
  end

  def set_task
    @task = @project.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :status, :assigned_user_id)
  end
end
