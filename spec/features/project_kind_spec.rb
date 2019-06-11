require 'rails_helper'

RSpec.feature 'project_kind', type: :feature do

  let(:resource_name) {ProjectKind.model_name.human}

  describe '#create project_kind' do

    before(:each) do
        visit new_project_kind_path
    end

    context 'with valid fields' do
      it 'create project_kind' do
        attributes = attributes_for(:project_kind)
        fill_in 'project_kind_kind', with: attributes[:kind]
        fill_in 'project_kind_description', with: attributes[:description]
    
        submit_form

        expect(page.current_path).to eq project_kinds_path

        expect(page).to have_selector('div.alert.alert-success',
                                      text: I18n.t('flash.actions.create',
                                                   resource_name: resource_name))

        expect_page_have_in('table tbody', attributes[:kind])
      end
    end

    context 'when invalid fields' do
      it 'cannot create project_kind' do
        submit_form
        expect(page).to have_selector('div.alert.alert-danger',
                                      text: I18n.t('flash.actions.errors'))
        have_contains('div.project_kind_kind', I18n.t('errors.messages.blank'))
      end
    end
  end

  describe '#update' do
    before(:each) do
      @project_kind = create :project_kind
      visit edit_project_kind_path(@project_kind)
    end
    context 'with valid fields' do
      it "update project_kind's fields" do
        new_kind = 'Tombamento'
        fill_in 'project_kind_kind', with: new_kind
        submit_form

        expect(page.current_path).to eq project_kind_path(@project_kind)
        expect(page).to have_content(new_kind.to_s)
      end
    end

    context 'when invalid fields' do
      it 'cannot update project_kind' do
        fill_in 'project_kind_kind', with: ''
        submit_form
        expect(page).to have_selector('div.alert.alert-danger',
                                      text: I18n.t('flash.actions.errors'))
        have_contains('div.project_kind_kind', I18n.t('errors.messages.blank'))
      end
    end
  end

  describe '#destroy' do
    it 'project_kind' do
      project_kind = create(:project_kind)
      visit project_kinds_path

      destroy_link = "a[href='#{project_kind_path(project_kind)}'][data-method='delete']"
      find(destroy_link).click

      expect(page).to have_selector('div.alert.alert-success',
                                    text: I18n.t('flash.actions.destroy',
                                                 resource_name: resource_name))

      expect_page_not_have_in('table tbody', project_kind.name)
    end
  end

  describe '#index' do
    let!(:project_kind) {create_list(:project_kind, 2)}

    it 'show all project_kind' do
      visit project_kinds_path

      project_kinds.each do |project_kind|
        expect(page).to have_content(project_kind.kind)
        expect(page).to have_content(project_kind.description)
        expect(page).to have_content(project_kind.projects.count)
        
        expect(page).to have_link(href: export_project_kind_path(project_kind))
        expect(page).to have_link(href: project_kind_path(project_kind))
        expect(page).to have_link(href: edit_project_kind_path(project_kind))
        destroy_link = "a[href='#{project_kind_path(project_kind)}'][data-method='delete']"
        expect(page).to have_css(destroy_link)
      end
    end
  end

  describe '#show' do
    context 'show project_kinds' do
      it 'show project_kinds page' do
        project_kind = create(:project_kind)
        visit project_kind_path(project_kind)

        expect(page).to have_content(project_kind.kind)
        expect(page).to have_content(project_kind.description)
      end
    end
end
end
