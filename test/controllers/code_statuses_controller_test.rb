require 'test_helper'

class CodeStatusesControllerTest < ActionController::TestCase
  setup do
    @code_status = code_statuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:code_statuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create code_status" do
    assert_difference('CodeStatus.count') do
      post :create, code_status: { description: @code_status.description, title: @code_status.title }
    end

    assert_redirected_to code_status_path(assigns(:code_status))
  end

  test "should show code_status" do
    get :show, id: @code_status
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @code_status
    assert_response :success
  end

  test "should update code_status" do
    patch :update, id: @code_status, code_status: { description: @code_status.description, title: @code_status.title }
    assert_redirected_to code_status_path(assigns(:code_status))
  end

  test "should destroy code_status" do
    assert_difference('CodeStatus.count', -1) do
      delete :destroy, id: @code_status
    end

    assert_redirected_to code_statuses_path
  end
end
