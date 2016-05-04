require 'test_helper'

class LineItemComparesControllerTest < ActionController::TestCase
  setup do
    @line_item_compare = line_item_compares(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:line_item_compares)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create line_item_compare" do
    assert_difference('LineItemCompare.count') do
      post :create, line_item_compare: { compare_id: @line_item_compare.compare_id, product_id: @line_item_compare.product_id }
    end

    assert_redirected_to line_item_compare_path(assigns(:line_item_compare))
  end

  test "should show line_item_compare" do
    get :show, id: @line_item_compare
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @line_item_compare
    assert_response :success
  end

  test "should update line_item_compare" do
    patch :update, id: @line_item_compare, line_item_compare: { compare_id: @line_item_compare.compare_id, product_id: @line_item_compare.product_id }
    assert_redirected_to line_item_compare_path(assigns(:line_item_compare))
  end

  test "should destroy line_item_compare" do
    assert_difference('LineItemCompare.count', -1) do
      delete :destroy, id: @line_item_compare
    end

    assert_redirected_to line_item_compares_path
  end
end
