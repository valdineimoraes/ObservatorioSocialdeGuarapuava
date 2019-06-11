require 'rails_helper'

RSpec.feature 'Councilman', type: :feature do

  let(:Councilman) {create :Councilman}
  let(:Councilman) {Councilman.model_name.human}

  before(:each) do
    login_as admin, scope: :admin
  end

  describe '#create councilmen' do

    before(:each) do
      @political_mandate = create_list(:political_mandate, 2).sample

      visit new_councilman_path
    end

    context 'with valid fields' do
      it 'create councilman' do
        attributes = attributes_for(:councilman)
        fill_in 'councilman_name', with: attributes[:name]
        fill_in 'councilman_nickname', with: attributes[:nickname]
        fill_in "councilman_office",	with: attributes [:office]
        fill_in "councilman_political_party",	with: attributes [:political_party]
        select @political_mandate.description, from: 'councilman[political_mandate_id]'
    
        submit_form

        expect(page.current_path).to eq councilmen_path

        expect(page).to have_selector('div.alert.alert-success',
                                      text: I18n.t('flash.actions.create',
                                                   resource_name: resource_name))

        expect_page_have_in('table tbody', attributes[:name])
      end
    end

    context 'when invalid fields' do
      it 'cannot create councilman' do
        submit_form
        expect(page).to have_selector('div.alert.alert-danger',
                                      text: I18n.t('flash.actions.errors'))
        have_contains('div.councilman_name', I18n.t('errors.messages.blank'))
        have_contains('div.councilman_nickname', I18n.t('errors.messages.blank'))
        have_contains('div.councilman_political_mandate', I18n.t('errors.messages.blank'))
      end
    end
  end

  describe '#update' do
    before(:each) do
      @councilman = create :councilman
      visit edit_councilman_path(@councilman)
    end
    context 'with valid fields' do
      it "update councilman's fields" do
        new_name = 'Maria da Silva'
        fill_in 'councilman_name', with: new_name
        submit_form

        expect(page.current_path).to eq councilman_path(@councilman)
        expect(page).to have_content(new_name.to_s)
      end
    end

    context 'when invalid fields' do
      it 'cannot update councilman' do
        fill_in 'councilman_name', with: ''
        submit_form
        expect(page).to have_selector('div.alert.alert-danger',
                                      text: I18n.t('flash.actions.errors'))
        have_contains('div.councilman_name', I18n.t('errors.messages.blank'))
      end
    end
  end

  describe '#destroy' do
    it 'councilman' do
      councilman = create(:councilman)
      visit councilman_path

      destroy_link = "a[href='#{councilman_path(councilman)}'][data-method='delete']"
      find(destroy_link).click

      expect(page).to have_selector('div.alert.alert-success',
                                    text: I18n.t('flash.actions.destroy',
                                                 resource_name: resource_name))

      expect_page_not_have_in('table tbody', councilman.name)
    end
  end

  describe '#index' do
    let!(:councilman) {create_list(:councilman, 2)}

    it 'show all councilman' do
      visit councilmen_path

      councilmen.each do |councilman|
        expect(page).to have_content(councilman.name)
        expect(page).to have_content(councilman.nickname) #######
        
        expect(page).to have_content(councilman.name)
        expect(page).to have_content(councilman.name)
        expect(page).to have_content(I18n.l(councilman.created_at, format: :long))

        expect(page).to have_link(href: admins_councilman_path(councilman))
        expect(page).to have_link(href: edit_admins_councilman_path(councilman))
        destroy_link = "a[href='#{admins_councilman_path(councilman)}'][data-method='delete']"
        expect(page).to have_css(destroy_link)
      end
    end
  end

  describe '#show' do
    context 'show councilmans' do
      it 'show councilman page' do
        councilman = create(:councilman)
        visit admins_councilman_path(councilman)

        expect(page).to have_content(councilman.name)
        expect(page).to have_content(councilman.gender)
        expect(page).to have_content(councilman.email)
        expect(page).to have_content(councilman.lattes)
        expect(page).to have_content(councilman.occupation_area)
        expect(page).to have_content(councilman.councilman_category.name)
        expect(page).to have_content(councilman.councilman_title.name)

      end
    end
  end
end
