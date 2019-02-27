require "application_system_test_case"

class SessionCouncilmenTest < ApplicationSystemTestCase
  setup do
    @session_councilman = session_councilmen(:one)
  end

  test "visiting the index" do
    visit session_councilmen_url
    assert_selector "h1", text: "Session Councilmen"
  end

  test "creating a Session councilman" do
    visit session_councilmen_url
    click_on "New Session Councilman"

    fill_in "Arrival", with: @session_councilman.arrival
    fill_in "Councilman", with: @session_councilman.councilman_id
    fill_in "Leaving", with: @session_councilman.leaving
    fill_in "Note", with: @session_councilman.note
    fill_in "Session", with: @session_councilman.session_id
    click_on "Create Session councilman"

    assert_text "Session councilman was successfully created"
    click_on "Back"
  end

  test "updating a Session councilman" do
    visit session_councilmen_url
    click_on "Edit", match: :first

    fill_in "Arrival", with: @session_councilman.arrival
    fill_in "Councilman", with: @session_councilman.councilman_id
    fill_in "Leaving", with: @session_councilman.leaving
    fill_in "Note", with: @session_councilman.note
    fill_in "Session", with: @session_councilman.session_id
    click_on "Update Session councilman"

    assert_text "Session councilman was successfully updated"
    click_on "Back"
  end

  test "destroying a Session councilman" do
    visit session_councilmen_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Session councilman was successfully destroyed"
  end
end
