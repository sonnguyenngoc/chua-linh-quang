class HomeController < ApplicationController
    def index
        @sliders = Article.get_lastest_blogs
        @galleries = GalleryImage.order("created_at DESC")
    end
end
