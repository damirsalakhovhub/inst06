class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = policy_scope(Project).where(organization: current_organization)
  end

  def show
    authorize @project
  end

  def new
    @project = Project.new(organization: current_organization)
    authorize @project
  end

  def create
    @project = Project.new(project_params)
    @project.organization = current_organization
    authorize @project

    if @project.save
      redirect_to @project, notice: "Project was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @project
  end

  def update
    authorize @project
    if @project.update(project_params)
      redirect_to @project, notice: "Project was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @project
    @project.destroy
    redirect_to projects_path, notice: "Project was successfully deleted."
  end

  private

  def set_project
    @project = current_organization.projects.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description)
  end
end
