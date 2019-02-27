class DashboardController < ApplicationController
    def index
        @meetings = Meeting.all
        @councilmen = Councilman.all
        @projects = Project.all
        @project_kinds = ProjectKind.all
    end
end
