# frozen_string_literal: true

require 'test_helper'

class SessionCouncilmenControllerTest < ActionDispatch::IntegrationTest
  setup do
    @session_councilman = session_councilmen(:one)
  end

  test 'should get index' do
    get session_councilmen_url
    assert_response :success
  end

  test 'should get new' do
    get new_session_councilman_url
    assert_response :success
  end

  test 'should create session_councilman' do
    assert_difference('SessionCouncilman.count') do
      post session_councilmen_url, params: { session_councilman: { arrival: @session_councilman.arrival, councilman_id: @session_councilman.councilman_id, leaving: @session_councilman.leaving, note: @session_councilman.note, session_id: @session_councilman.session_id } }
    end

    assert_redirected_to session_councilman_url(SessionCouncilman.last)
  end

  test 'should show session_councilman' do
    get session_councilman_url(@session_councilman)
    assert_response :success
  end

  test 'should get edit' do
    get edit_session_councilman_url(@session_councilman)
    assert_response :success
  end

  test 'should update session_councilman' do
    patch session_councilman_url(@session_councilman), params: { session_councilman: { arrival: @session_councilman.arrival, councilman_id: @session_councilman.councilman_id, leaving: @session_councilman.leaving, note: @session_councilman.note, session_id: @session_councilman.session_id } }
    assert_redirected_to session_councilman_url(@session_councilman)
  end

  test 'should destroy session_councilman' do
    assert_difference('SessionCouncilman.count', -1) do
      delete session_councilman_url(@session_councilman)
    end

    assert_redirected_to session_councilmen_url
  end
end
