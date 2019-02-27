require "application_system_test_case"

class ProjectsTest < ApplicationSystemTestCase
  setup do
    @project = projects(:one)
  end

  test "visiting the index" do
    visit projects_url
    assert_selector "h1", text: "Projects"
  end

  test "creating a Project" do
    visit projects_url
    click_on "New Project"

    fill_in "Description", with: @project.description
    fill_in "End Project", with: @project.end_project
    fill_in "Name", with: @project.name
    fill_in "Project Kind", with: @project.project_kind_id
    fill_in "Result", with: @project.result
    fill_in "Session", with: @project.session_id
    fill_in "Start Project", with: @project.start_project
    click_on "Create Project"

    assert_text "Project was successfully created"
    click_on "Back"
  end

  test "updating a Project" do
    visit projects_url
    click_on "Edit", match: :first

    fill_in "Description", with: @project.description
    fill_in "End Project", with: @project.end_project
    fill_in "Name", with: @project.name
    fill_in "Project Kind", with: @project.project_kind_id
    fill_in "Result", with: @project.result
    fill_in "Session", with: @project.session_id
    fill_in "Start Project", with: @project.start_project
    click_on "Update Project"

    assert_text "Project was successfully updated"
    click_on "Back"
  end

  test "destroying a Project" do
    visit projects_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Project was successfully destroyed"
  end
end
