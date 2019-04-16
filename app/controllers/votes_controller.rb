class VotesController < ApplicationController
  before_action :set_vote, only: %i[show edit update destroy]

  def new
    @project = Project.find(params[:project_id])
    @councilmen = Councilman.all
    @vote = Vote.new
  end

  def create
    @project = Project.find(params[:project_id])

    params[:vote].each do |councilman_id, options|
      v = @project.votes.find_by councilman_id: councilman_id
      if v.nil?
        @project.votes.create councilman_id: councilman_id,
                              vote: options[:vote]
      else
        v.update_attributes(vote: options[:vote])
      end
    end
    redirect_back(fallback_location: root_path)
  end

  def update
    if @vote.update(vote_params)
      flash[:success] = 'Vote was successfully updated.'
      redirect_to @vote
    else
      flash[:error] = 'Existem dados incorretos! Por favor verifique.'
      render :edit
    end
  end

  def destroy
    @vote.destroy
    flash[:success] = 'Vote was successfully destroyed.'
    redirect_to votes_url
  end
end

private

def set_vote
  @vote = Vote.find(params[:id])
end

def vote_params
  params.require(:vote).permit(:project_id, :councilman_id, :vote)
end
