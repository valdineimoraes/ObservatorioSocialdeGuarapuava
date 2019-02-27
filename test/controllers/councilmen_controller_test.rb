require 'test_helper'

class CouncilmenControllerTest < ActionDispatch::IntegrationTest
  setup do
    @councilman = councilmen(:one)
  end

  test "should get index" do
    get councilmen_url
    assert_response :success
  end

  test "should get new" do
    get new_councilman_url
    assert_response :success
  end

  test "should create councilman" do
    assert_difference('Councilman.count') do
      post councilmen_url, params: { councilman: { name: @councilman.name, nickname: @councilman.nickname, political_party: @councilman.political_party, political_position: @councilman.political_position } }
    end

    assert_redirected_to councilman_url(Councilman.last)
  end

  test "should show councilman" do
    get councilman_url(@councilman)
    assert_response :success
  end

  test "should get edit" do
    get edit_councilman_url(@councilman)
    assert_response :success
  end

  test "should update councilman" do
    patch councilman_url(@councilman), params: { councilman: { name: @councilman.name, nickname: @councilman.nickname, political_party: @councilman.political_party, political_position: @councilman.political_position } }
    assert_redirected_to councilman_url(@councilman)
  end

  test "should destroy councilman" do
    assert_difference('Councilman.count', -1) do
      delete councilman_url(@councilman)
    end

    assert_redirected_to councilmen_url
  end
end
