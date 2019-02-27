class ProjectKindsController < ApplicationController
  before_action :set_project_kind, only: [:show, :edit, :update, :destroy]

  def index
    if params[:search]
      @project_kinds = ProjectKind.search(params[:search]).paginate(:page => params[:page], :per_page => 5).order(kind: :asc)
    else  
      @project_kinds = ProjectKind.all.paginate(:page => params[:page], :per_page => 5).order(kind: :asc)
    end
  end

  def show
  end

  def new
    @project_kind = ProjectKind.new
  end

  def edit
  end

  def create
    @project_kind = ProjectKind.new(project_kind_params)

    respond_to do |format|
      if @project_kind.save
        format.html { redirect_to @project_kind, notice: 'Tipo de projeto criado com sucesso.' }
        format.json { render :show, status: :created, location: @project_kind }
      else
        format.html { render :new }
        format.json { render json: @project_kind.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @project_kind.update(project_kind_params)
        format.html { redirect_to @project_kind, notice: 'Tipo de projeto atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @project_kind }
      else
        format.html { render :edit }
        format.json { render json: @project_kind.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project_kind.destroy
    respond_to do |format|
      format.html { redirect_to project_kinds_url, notice: 'Tipo de projeto deletado.' }
      format.json { head :no_content }
    end
  end

  private
    
    def set_project_kind
      @project_kind = ProjectKind.find(params[:id])
    end

    def project_kind_params
      params.require(:project_kind).permit(:kind, :description)
    end
end
