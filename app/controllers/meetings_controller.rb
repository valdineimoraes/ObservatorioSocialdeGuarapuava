class MeetingsController < ApplicationController
  before_action :set_meeting, :set_session_councilmen, only: %i[show edit update destroy]

  def index
    @meetings = Meeting.all.paginate(page: params[:page], per_page: 10)
                    .order(date: :desc)
  end

  def show; end

  def new
    @meeting = Meeting.new
  end

  def edit; end

  def create
    @meeting = Meeting.new(meeting_params)
    if @meeting.save
      flash[:success] = 'Sessão criada com sucesso!'
      redirect_to meetings_url
    else
      flash[:error] = 'Houve algum problema, reveja os dados inseridos !'
      render :new
    end
  end

  def update
    if @meeting.update(meeting_params)
      flash[:success] = 'Sessão atualizada com sucesso!'
      redirect_to @meeting
    else
      flash[:error] = 'Houve algum problema, reveja os dados inseridos !'
      render :edit
    end
  end

  def destroy
    @meeting.destroy
    flash[:success] = 'Sessão removida com sucesso!'
    redirect_to meetings_url
  end

  def projects
    @meeting = Meeting.find(params[:meeting_id])
  end

  def presents
    @meeting = Meeting.find(params[:meeting_id])

    Councilman.all.each do |c|
      @meeting.session_councilmen.find_or_create_by!(councilman_id: c.id)
    end
  end

  def update_presents
    @meeting = Meeting.find(params[:meeting_id])
    sc_params = params.require(:meeting)
                    .permit(session_councilmen_attributes:
                                %i[id note present arrival leaving])

    if @meeting.update(sc_params)
      flash[:success] = 'Dados atualizados com sucesso'
    else
      flash[:error] = 'Não foi possível atualizar os dados'
    end
    redirect_back(fallback_location: root_path)
  end

  def new_project
    @meeting = Meeting.find(params[:meeting_id])
    @project = Project.new
  end

  private

  def set_meeting
    @meeting = Meeting.find(params[:id])
  end

  def set_session_councilmen
    @session_councilmen = SessionCouncilman.find(@meeting.session_councilman_ids)
  end

  def meeting_params
    params.require(:meeting).permit(:date,
                                    :start_session,
                                    :end_session,
                                    :note)
  end
end
