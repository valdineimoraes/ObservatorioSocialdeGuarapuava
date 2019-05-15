class DashboardController < ApplicationController
  add_breadcrumb 'Dashboard', :root_path

  def index
    @meetings = Meeting.all
    @councilmen = Councilman.all
    @projects = Project.all
    @project_kinds = ProjectKind.all
    @political_mandates = PoliticalMandate.all
  end
end
