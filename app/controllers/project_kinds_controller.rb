class ProjectKindsController < ApplicationController
  before_action :set_project_kind, only: [:show, :edit, :update, :destroy, :export]
  require './lib/pdfs/project_kind_pdf'

  add_breadcrumb I18n.t('breadcrumbs.project_kind.name'), :project_kinds_path
  add_breadcrumb I18n.t('breadcrumbs.project_kind.new'),
                 :new_project_kind_path, only: [:new, :create]

  def index
    if params[:search]
      @project_kinds = ProjectKind.search(params[:search]).paginate(page: params[:page],
                                                                    per_page: 10).order(kind: :asc)
    else
      @project_kinds = ProjectKind.all.paginate(page: params[:page],
                                                per_page: 10).order(kind: :asc)
    end
  end

  def show; end

  def new
    @project_kind = ProjectKind.new
  end

  def edit
    add_breadcrumb I18n.t('breadcrumbs.project_kind.edit', name: "##{@project_kind.id}"),
                   :edit_project_kind_path
  end

  def create
    @project_kind = ProjectKind.new(project_kind_params)
    if @project_kind.save
      flash[:success] = 'Tipo de projeto criado com sucesso!'
      redirect_to project_kinds_path
    else
      flash[:error] = 'Houve algum problema, reveja os dados inseridos !'
      render :new
    end
  end

  def update
    if @project_kind.update(project_kind_params)
      flash[:success] = 'Tipo de projeto atualizado com sucesso!'
      redirect_to project_kinds_path
    else
      add_breadcrumb I18n.t('breadcrumbs.project_kind.edit', name: "##{@project_kind.id}"),
                     :edit_project_kind_path
      flash[:error] = 'Houve algum problema, reveja os dados inseridos !'
      render :edit
    end
  end

  # export pdf - prawn pdf
  def export
    ProjectKindPdf.project_kind(@project_kind.kind, @project_kind.description,
                                @project_kind.projects.count,
                                @project_kind.projects)
    redirect_to '/pdfs/project_kind.pdf'
  end

  def projects
    @project_kind = ProjectKind.find(params[:project_kind_id])
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
  params.require(:project_kind).permit(:kind,
                                       :description)
end
