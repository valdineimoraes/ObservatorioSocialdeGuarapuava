class ProjectsController < ApplicationController
  before_action :set_project, :set_meeting, :set_session_councilmen,
                only: %i[show edit update destroy]
  after_action :set_result, only: [:update_votes]

  add_breadcrumb I18n.t('breadcrumbs.project.name'), :projects_path
  add_breadcrumb I18n.t('breadcrumbs.project.new'),
                 :new_project_path, only: %i[new create]

  def index
    if params[:search]
      @projects = Project.search(params[:search]).paginate(page: params[:page],
                                                           per_page: 10).order(name: :asc)
    else
      @projects = Project.all.paginate(page: params[:page], per_page: 10)
                         .order(name: :asc)
    end
  end

  def show
    add_breadcrumb I18n.t('breadcrumbs.project.show',
                          name: "##{@project.id}"), :project_path
  end

  def new
    @project = Project.new
  end

  def edit
    add_breadcrumb I18n.t('breadcrumbs.project.edit', name: "##{@project.id}"),
                   :edit_project_path
  end

  def votes
    @project = Project.find(params[:project_id])
  end

  def votes
    add_breadcrumb I18n.t('breadcrumbs.project.vote'),
                   :project_votes_path

    @project = Project.find(params[:project_id])

    Councilman.all.each do |c|
      @project.votes.find_or_create_by!(councilman_id: c.id)
    end
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      flash[:success] = 'Pauta criada com sucesso!'
      redirect_to @project
    else
      flash[:error] = 'Existem dados incorretos! Por favor verifique.'
      render :new
    end
  end

  def update
    if @project.update(project_params)
      flash[:success] = 'Pauta atualizada com sucesso!'
      redirect_to @project
    else
      add_breadcrumb I18n.t('breadcrumbs.project.edit', name: "##{@project.id}"),
                     :edit_project_path
      flash[:error] = 'Existem dados incorretos! Por favor verifique.'
      render :edit
    end
  end

  def update_votes
    add_breadcrumb I18n.t('breadcrumbs.project.vote_update'),
                   :project_votes_path
    @project = Project.find(params[:project_id])
    vote_params = params.require(:project).permit(votes_attributes: %i[id vote])


    if @project.update(vote_params)
      flash[:success] = 'Votos atualizados com sucesso'
    else
      flash[:error] = 'Não foi possível atualizar os dados'
    end
    redirect_to action: 'index'
  end

  def destroy
    @project.destroy
    redirect_to projects_url, notice: 'Project was successfully destroyed.'
  end

  def quorum
    presentes = Councilman.joins(:session_councilmen)
                          .where(session_councilmen: {
                                   meeting_id: @project.meeting_id,
                                   present: true
                                 }).count

    quorum = presentes * 100 / Councilman.all.size
    quorum
  end

  private

  def countvote
    votes = @project.votes.group(:vote).count
  end

  def set_result
    if quorum < 66
      @project.postponed!
    else
      favoravel = countvote['favorable'] * 100 / countvote.values.sum
      if favoravel > 50
        @project.approved!
      else
        @project.rejected!
      end
    end
  end

  def set_project
    @project = Project.find(params[:id])
  end

  def set_meeting
    @meeting = Meeting.find(@project.meeting_id)
  end

  def set_session_councilmen
    @session_councilmen = SessionCouncilman.find(@meeting.session_councilman_ids)
  end

  def project_params
    params.require(:project).permit(:meeting_id,
                                    :councilman_id,
                                    :name,
                                    :description,
                                    :project_kind_id,
                                    :start_project,
                                    :end_project,
                                    :result)
  end
end
