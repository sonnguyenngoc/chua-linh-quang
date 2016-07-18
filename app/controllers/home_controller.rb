class HomeController < ApplicationController
    def index
        @sliders = Article.get_lastest_blogs
    end
end
