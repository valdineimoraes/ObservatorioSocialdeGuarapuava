require 'rails_helper'

RSpec.describe 'Political_Mandates', type: :feature do
  describe '#create' do
    before do
      visit new_political_mandate_path
    end

    context 'with valid fields' do
      it 'create political_mandate' do
        attributes = attributes_for(:political_mandate)

        fill_in 'political_mandate_description', with: attributes[:description]

        select '1', from: 'political_mandate[first_period(3i)]'
        select 'Janeiro', from: 'political_mandate[first_period(2i)]'
        select '2017', from: 'political_mandate[first_period(1i)]'

        select '30', from: 'political_mandate[final_period(3i)]'
        select 'Dezembro', from: 'political_mandate[final_period(2i)]'
        select '2021', from: 'political_mandate[final_period(1i)]'

        submit_form

        expect(page).to have_current_path(political_mandate_path)

        expect_alert_success(resource_name, 'flash.create')

        within('table tbody') do
          expect(page).to have_content(attributes[:description])
        end
      end
    end

    context 'when invalid fields' do
      it 'show errors' do
        submit_form

        expect(page).to have_selector('div.alert.alert-danger',
                                      text: I18n.t('flash.actions.errors'))

        within('div.political_mandate_first_period') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
      end
    end
  end

  describe '#update' do
    let(:political_mandate) { create(:political_mandate) }

    before do
      visit edit_political_mandate_path(political_mandate)
    end

    context 'fill fields' do
      it 'with correct values' do
        expect(page).to have_field 'political_mandate_description', with: political_mandate.description
      end
    end

    context 'with valid fields' do
      it 'update political_mandate' do
        new_mandate = 'MandatoXXXX'
        fill_in 'political_mandate_description', with: new_mandate

        submit_form

        expect(page).to have_current_path political_mandates_path

        expect(page).to have_selector('div.alert.alert-success',
                                      text: 'Mandato politico atualizado com sucesso! ')

        within('table tbody') do
          expect(page).to have_content(new_mandate)
        end
      end
    end

    context 'when invalid fields' do
      it 'show errors' do
        fill_in 'political_mandate_description', with: ''
        submit_form

        expect(page).to have_selector('div.alert.alert-danger',
                                      text: I18n.t('flash.actions.errors'))

        within('div.political_mandate_description') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
      end
    end
  end

  describe '#destroy' do
    it 'political_mandate' do
      political_mandate = create(:political_mandate)
      visit political_mandates_path

      destroy_link = "a[href='#{political_mandate_path(political_mandate)}'][data-method='delete']"
      find(destroy_link).click

      expect(page).to have_selector('div.alert.alert-success',
                                    text: 'Mandato politico destruido com sucesso! ')

      within('table tbody') do
        expect(page).not_to have_content(political_mandate.description)
      end
    end
  end

  describe '#index' do
    let!(:political_mandates) { create_list(:political_mandate, 3) }

    it 'show all political_mandate with options' do
      visit political_mandates_path

      political_mandates.each do |political_mandate|
        expect(page).to have_content(political_mandate.description)
        expect(page).to have_content(political_mandate.first_period)
        expect(page).to have_content(political_mandate.final_period)

        expect(page).to have_link(href: edit_political_mandate_path(political_mandate))
        expect(page).to have_link(href: political_mandate_path(political_mandate))

        destroy_link = "a[href='#{political_mandate_path(political_mandate)}'][data-method='delete']"
        expect(page).to have_css(destroy_link)
      end
    end
  end
end
