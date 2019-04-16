class ProjectKindsController < ApplicationController
  before_action :set_project_kind, only: %i[show edit update destroy]

  def index
    if params[:search]
      @project_kinds = ProjectKind.search(params[:search]).paginate(page: params[:page], per_page: 5).order(kind: :asc)
    else
      @project_kinds = ProjectKind.all.paginate(page: params[:page], per_page: 5).order(kind: :asc)
    end
  end

  def show; end

  def new
    @project_kind = ProjectKind.new
  end

  def edit; end

  def create
    @project_kind = ProjectKind.new(project_kind_params)
    if @project_kind.save
      flash[:success] = 'Tipo de projeto criado com sucesso!'
      redirect_to @project_kind
    else
      flash[:error] = 'Houve algum problema, reveja os dados inseridos !'
      render :new
    end
  end

  def update
    if @project_kind.update(project_kind_params)
      flash[:success] = 'Tipo de projeto atualizado com sucesso!'
      redirect_to @project_kind
    else
      flash[:error] = 'Houve algum problema, reveja os dados inseridos !'
      render :edit
    end
  end

  def destroy
    @project_kind.destroy
    flash[:success] = 'Tipo de projeto removido com sucesso!'
    redirect_to project_kinds_url
  end
end

private

def set_project_kind
  @project_kind = ProjectKind.find(params[:id])
end

def project_kind_params
  params.require(:project_kind).permit(:kind, :description)
end
