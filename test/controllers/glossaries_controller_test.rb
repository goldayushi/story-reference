# frozen_string_literal: true

require 'test_helper'

class GlossariesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get glossaries_index_url
    assert_response :success
  end

  test 'should get new' do
    get glossaries_new_url
    assert_response :success
  end

  test 'should get create' do
    get glossaries_create_url
    assert_response :success
  end

  test 'should get show' do
    get glossaries_show_url
    assert_response :success
  end

  test 'should get edit' do
    get glossaries_edit_url
    assert_response :success
  end

  test 'should get update' do
    get glossaries_update_url
    assert_response :success
  end

  test 'should get destroy' do
    get glossaries_destroy_url
    assert_response :success
  end
end
