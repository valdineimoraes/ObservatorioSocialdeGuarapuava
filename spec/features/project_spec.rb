require 'rails_helper'

RSpec.feature 'project', type: :feature do

  let(:resource_name) {Project.model_name.human}

  describe '#create project' do

    before(:each) do
        @meeting = create_list(:meeting, 2).sample
        @councilmen = create_list(:councilmen, 2).sample
        @project_kind = create_list(:project_kind, 2).sample
        
        visit new_project_path
    end

    context 'with valid fields' do
      it 'create project' do
        attributes = attributes_for(:project)
        select @meeting.date, from: 'project[meeting_id]'
        select @councilmen.date, from: 'project[councilman_id]'
        fill_in 'project_name', with: attributes[:name]
        select @project_kind.kind, from: 'project[project_kind_id]'
        fill_in 'project_description', with: attributes[:description]
    
        submit_form

        expect(page.current_path).to eq projects_path

        expect(page).to have_selector('div.alert.alert-success',
                                      text: I18n.t('flash.actions.create',
                                                   resource_name: resource_name))

        expect_page_have_in('table tbody', attributes[:name])
      end
    end

    ####### fiz até aqui #####

    context 'when invalid fields' do
      it 'cannot create project' do
        submit_form
        expect(page).to have_selector('div.alert.alert-danger',
                                      text: I18n.t('flash.actions.errors'))
        have_contains('div.project_kind', I18n.t('errors.messages.blank'))
      end
    end
  end

  describe '#update' do
    before(:each) do
      @project = create :project
      visit edit_project_path(@project)
    end
    context 'with valid fields' do
      it "update project's fields" do
        new_kind = 'Tombamento'
        fill_in 'project_kind', with: new_kind
        submit_form

        expect(page.current_path).to eq project_path(@project)
        expect(page).to have_content(new_kind.to_s)
      end
    end

    context 'when invalid fields' do
      it 'cannot update project' do
        fill_in 'project_kind', with: ''
        submit_form
        expect(page).to have_selector('div.alert.alert-danger',
                                      text: I18n.t('flash.actions.errors'))
        have_contains('div.project_kind', I18n.t('errors.messages.blank'))
      end
    end
  end

  describe '#destroy' do
    it 'project' do
      project = create(:project)
      visit projects_path

      destroy_link = "a[href='#{project_path(project)}'][data-method='delete']"
      find(destroy_link).click

      expect(page).to have_selector('div.alert.alert-success',
                                    text: I18n.t('flash.actions.destroy',
                                                 resource_name: resource_name))

      expect_page_not_have_in('table tbody', project.name)
    end
  end

  describe '#index' do
    let!(:project) {create_list(:project, 2)}

    it 'show all project' do
      visit projects_path

      projects.each do |project|
        expect(page).to have_content(project.kind)
        expect(page).to have_content(project.description)
        expect(page).to have_content(project.projects.count)
        
        expect(page).to have_link(href: export_project_path(project))
        expect(page).to have_link(href: project_path(project))
        expect(page).to have_link(href: edit_project_path(project))
        destroy_link = "a[href='#{project_path(project)}'][data-method='delete']"
        expect(page).to have_css(destroy_link)
      end
    end
  end

  describe '#show' do
    context 'show projects' do
      it 'show projects page' do
        project = create(:project)
        visit project_path(project)

        expect(page).to have_content(project.kind)
        expect(page).to have_content(project.description)
      end
    end
end
end
