# frozen_string_literal: true

crumb :root do
  link 'Dashboard', root_path
end

crumb :projects do
  link 'Projetos', projects_path
end

crumb :edit_project do |p|
  link 'Editar Pauta', p
  parent :projects, p
end

crumb :new_project do |p|
  link 'Novo Pauta', p
  parent :projects, p
end

crumb :show_project do |p|
  link " #{p.name}", p
  parent :projects, p
end

crumb :project_votes do |p|
  link " Votos da Pauta: #{p.name}", p
  parent :projects, p
end

###############
crumb :councilmen do
  link 'Vereadores', councilmen_path
end

crumb :edit_councilman do |c|
  link 'Editar Vereador', c
  parent :councilmen, c
end

crumb :new_councilman do |c|
  link 'Novo Vereador', c
  parent :councilmen, c
end

crumb :show_councilman do |c|
  link " #{c.name}", c
  parent :councilmen, c
end
###############

crumb :project_kinds do
  link 'Tipos de Projeto', project_kinds_path
end

crumb :edit_project_kind do |pk|
  link 'Editar Tipo de Projeto', pk
  parent :project_kinds, pk
end

crumb :new_project_kind do |pk|
  link 'Novo Tipo de Projeto', pk
  parent :project_kinds, pk
end

crumb :show_project_kind do |pk|
  link " #{pk.name}", pk
  parent :project_kinds, pk
end

###############
crumb :meetings do
  link 'Sessões', meetings_path
end

crumb :edit_meeting do |s|
  link 'Editar Sessão', s
  parent :meetings, s
end

crumb :new_meeting do |s|
  link 'Nova Sessão', s
  parent :meetings, s
end

crumb :show_meeting do |s|
  link "Data: #{s.date.strftime('%d/%m/%Y')}", s
  parent :meetings, s
end

crumb :meeting_presents do |s|
  link "Vereadores Presentes na Sessão: #{s.date.strftime('%d/%m/%Y')}", s
  parent :meetings, s
end

###############

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
