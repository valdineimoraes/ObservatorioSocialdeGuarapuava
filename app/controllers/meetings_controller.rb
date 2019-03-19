# frozen_string_literal: true

class MeetingsController < ApplicationController
  before_action :set_meeting, :set_session_councilmen, only: %i[show edit update destroy]

  def index
    @meetings = Meeting.all.paginate(page: params[:page], per_page: 5)
                       .order(date: :desc)
  end

  def show; end

  def new
    @meeting = Meeting.new
  end

  def edit; end

  def create
    @meeting = Meeting.new(meeting_params)

    respond_to do |format|
      if @meeting.save
        format.html { redirect_to @meeting, notice: 'Sessão criada com sucesso.' }
        format.json { render :show, status: :created, location: @meeting }
      else
        format.html { render :new }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to @meeting, notice: 'Sessão atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @meeting }
      else
        format.html { render :edit }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @meeting.destroy
    respond_to do |format|
      format.html { redirect_to meetings_url, notice: 'Sessão removida com sucesso.' }
      format.json { head :no_content }
    end
  end

  def projects
    @meeting = Meeting.find(params[:meeting_id])
  end

  def presents
    @meeting = Meeting.find(params[:meeting_id])

    ## Cuidado com esse código, como lhe falei você precisa pensar nos mandatos
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

  ### projetos na sessão
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
    params.require(:meeting).permit(:date, :start_session, :end_session, :note)
  end
end
