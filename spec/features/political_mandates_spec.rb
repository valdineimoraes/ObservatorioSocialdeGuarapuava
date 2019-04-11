require 'rails_helper'

RSpec.describe 'Political_Mandates', type: :feature do
  describe '#create' do
    before(:each) do
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

        expect_page_have_in('table tbody', attributes[:description])
      end
    end
  end
end
