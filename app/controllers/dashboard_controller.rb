class DashboardController < ApplicationController
  def index
    @meetings = Meeting.all
    @councilmen = Councilman.all
    @projects = Project.all
    @project_kinds = ProjectKind.all
    @political_mandates = PoliticalMandate.all
  end
end
