require 'test_helper'

class AlbumsControllerTest < ActionController::TestCase
  setup do
    @album = albums(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:albums)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create album" do
    assert_difference('Album.count') do
      post :create, album: { description: @album.description, image_url: @album.image_url, link: @album.link, title: @album.title, user_id: @album.user_id }
    end

    assert_redirected_to album_path(assigns(:album))
  end

  test "should show album" do
    get :show, id: @album
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @album
    assert_response :success
  end

  test "should update album" do
    patch :update, id: @album, album: { description: @album.description, image_url: @album.image_url, link: @album.link, title: @album.title, user_id: @album.user_id }
    assert_redirected_to album_path(assigns(:album))
  end

  test "should destroy album" do
    assert_difference('Album.count', -1) do
      delete :destroy, id: @album
    end

    assert_redirected_to albums_path
  end
end
