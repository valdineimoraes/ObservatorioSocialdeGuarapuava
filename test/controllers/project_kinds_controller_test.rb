# frozen_string_literal: true

require 'test_helper'

class ProjectKindsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project_kind = project_kinds(:one)
  end

  test 'should get index' do
    get project_kinds_url
    assert_response :success
  end

  test 'should get new' do
    get new_project_kind_url
    assert_response :success
  end

  test 'should create project_kind' do
    assert_difference('ProjectKind.count') do
      post project_kinds_url, params: { project_kind: { description: @project_kind.description, kind: @project_kind.kind } }
    end

    assert_redirected_to project_kind_url(ProjectKind.last)
  end

  test 'should show project_kind' do
    get project_kind_url(@project_kind)
    assert_response :success
  end

  test 'should get edit' do
    get edit_project_kind_url(@project_kind)
    assert_response :success
  end

  test 'should update project_kind' do
    patch project_kind_url(@project_kind), params: { project_kind: { description: @project_kind.description, kind: @project_kind.kind } }
    assert_redirected_to project_kind_url(@project_kind)
  end

  test 'should destroy project_kind' do
    assert_difference('ProjectKind.count', -1) do
      delete project_kind_url(@project_kind)
    end

    assert_redirected_to project_kinds_url
  end
end
