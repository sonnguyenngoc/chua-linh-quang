require 'test_helper'

class GalleryControllerTest < ActionController::TestCase
  test "should get music" do
    get :music
    assert_response :success
  end

  test "should get picture" do
    get :picture
    assert_response :success
  end

  test "should get video" do
    get :video
    assert_response :success
  end

end
