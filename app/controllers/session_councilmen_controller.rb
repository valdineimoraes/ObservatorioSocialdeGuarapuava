class SessionCouncilmenController < ApplicationController
  before_action :set_session_councilman, only: [:show, :edit, :update, :destroy]

  def index
    @session_councilmen = SessionCouncilman.all
  end

  def new
    @meeting = Meeting.find(params[:meeting_id])
    @councilmen = Councilman.all
    @session_councilman = SessionCouncilman.new
  end

  def create
    @meeting = Meeting.find(params[:meeting_id])

    params[:session_councilman].each do |councilman_id, options|
      sc = @meeting.session_councilmen.find_by councilman_id: councilman_id
      if sc.nil?
        @meeting.session_councilmen.create councilman_id: councilman_id,
                                           note: options[:note],
                                           being: options[:being]
      else
        sc.update(note: options[:note], being: options[:being])
      end
    end
    redirect_back(fallback_location: root_path)
  end

  def update
    if @session_councilman.update(session_councilman_params)
      flash[:success] = 'Session councilman was successfully updated.'
      redirect_to @meeting
    else
      flash[:error] = 'Existem dados incorretos! Por favor verifique.'
      render :edit
    end
  end

  def destroy
    @session_councilman.destroy
    flash[:success] = 'Session councilman was successfully destroyed.'
    redirect_to session_councilmen_url
  end
end

private

def set_session_councilman
  @session_councilman = SessionCouncilman.find(params[:id])
end

def session_councilman_params
  params.require(:session_councilman).permit(:being, :note)
end
