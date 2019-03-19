# frozen_string_literal: true

require 'application_system_test_case'

class ProjectKindsTest < ApplicationSystemTestCase
  setup do
    @project_kind = project_kinds(:one)
  end

  test 'visiting the index' do
    visit project_kinds_url
    assert_selector 'h1', text: 'Project Kinds'
  end

  test 'creating a Project kind' do
    visit project_kinds_url
    click_on 'New Project Kind'

    fill_in 'Description', with: @project_kind.description
    fill_in 'Kind', with: @project_kind.kind
    click_on 'Create Project kind'

    assert_text 'Project kind was successfully created'
    click_on 'Back'
  end

  test 'updating a Project kind' do
    visit project_kinds_url
    click_on 'Edit', match: :first

    fill_in 'Description', with: @project_kind.description
    fill_in 'Kind', with: @project_kind.kind
    click_on 'Update Project kind'

    assert_text 'Project kind was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Project kind' do
    visit project_kinds_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Project kind was successfully destroyed'
  end
end
