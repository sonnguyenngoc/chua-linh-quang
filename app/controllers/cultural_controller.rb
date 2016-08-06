class CulturalController < ApplicationController
    def index
        @articles = Article.get_all_cultural_blogs.paginate(:page => params[:page], :per_page => 9)
    end
    
    def cultural_sub_1
        @articles = Article.get_all_cultural_sub_1_blogs.paginate(:page => params[:page], :per_page => 8)
    end
    
    def cultural_sub_2
        @articles = Article.get_all_cultural_sub_2_blogs.paginate(:page => params[:page], :per_page => 8)
    end
    
    def cultural_sub_3
        @galleries = Gallery.get_all_galleries.paginate(:page => params[:page], :per_page => 8)
    end
    
    def cultural_sub_4
    end
    
    def gallery_detail
        @gallery = Gallery.find(params[:gallery_id])
    end
end