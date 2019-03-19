# frozen_string_literal: true

json.extract! project, :id, :meeting_id, :name, :description, :project_kind_id, :start_project, :end_project, :result, :created_at, :updated_at
json.url project_url(project, format: :json)
