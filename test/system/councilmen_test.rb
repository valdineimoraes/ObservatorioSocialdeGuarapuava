# frozen_string_literal: true

require 'application_system_test_case'

class CouncilmenTest < ApplicationSystemTestCase
  setup do
    @councilman = councilmen(:one)
  end

  test 'visiting the index' do
    visit councilmen_url
    assert_selector 'h1', text: 'Councilmen'
  end

  test 'creating a Councilman' do
    visit councilmen_url
    click_on 'New Councilman'

    fill_in 'Name', with: @councilman.name
    fill_in 'Nickname', with: @councilman.nickname
    fill_in 'Political Party', with: @councilman.political_party
    fill_in 'Political Position', with: @councilman.political_position
    click_on 'Create Councilman'

    assert_text 'Councilman was successfully created'
    click_on 'Back'
  end

  test 'updating a Councilman' do
    visit councilmen_url
    click_on 'Edit', match: :first

    fill_in 'Name', with: @councilman.name
    fill_in 'Nickname', with: @councilman.nickname
    fill_in 'Political Party', with: @councilman.political_party
    fill_in 'Political Position', with: @councilman.political_position
    click_on 'Update Councilman'

    assert_text 'Councilman was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Councilman' do
    visit councilmen_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Councilman was successfully destroyed'
  end
end
