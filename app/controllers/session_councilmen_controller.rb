class SessionCouncilmenController < ApplicationController
  before_action :set_session_councilman, only: %i[show edit update destroy]

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
        sc.update_attributes(note: options[:note], being: options[:being])
      end
    end
    redirect_back(fallback_location: root_path)
  end

  def update
    if @session_councilman.update(session_councilman_params)
      redirect_to @session_councilman, notice: 'Session councilman was successfully updated.'
      render :show, status: :ok, location: @session_councilman
    else
      render :edit
      render json: @session_councilman.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @session_councilman.destroy
    redirect_to session_councilmen_url, notice: 'Session councilman was successfully destroyed.'
    head :no_content
  end
end

private

def set_session_councilman
  @session_councilman = SessionCouncilman.find(params[:id])
end

def session_councilman_params
  params.require(:session_councilman).permit(:being, :note)
end
