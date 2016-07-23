class CulturalController < ApplicationController
    def index
        @articles = Article.get_all_cultural_blogs.paginate(:page => params[:page], :per_page => 3)
    end
    
    def cultural_sub_1
        @articles = Article.get_all_cultural_sub_1_blogs.paginate(:page => params[:page], :per_page => 3)
    end
    
    def cultural_sub_2
        @articles = Article.get_all_cultural_sub_2_blogs.paginate(:page => params[:page], :per_page => 3)
    end
    
    def cultural_sub_3
    end
    
    def cultural_sub_4
    end
end
