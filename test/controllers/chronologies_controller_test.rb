require 'test_helper'

class ChronologiesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get chronologies_index_url
    assert_response :success
  end

  test "should get new" do
    get chronologies_new_url
    assert_response :success
  end

  test "should get create" do
    get chronologies_create_url
    assert_response :success
  end

  test "should get show" do
    get chronologies_show_url
    assert_response :success
  end

  test "should get edit" do
    get chronologies_edit_url
    assert_response :success
  end

  test "should get update" do
    get chronologies_update_url
    assert_response :success
  end

  test "should get destroy" do
    get chronologies_destroy_url
    assert_response :success
  end

end
