class BuddhistBookController < ApplicationController
  def index
    @articles = Article.get_all_buddhist_book_blogs.paginate(:page => params[:page], :per_page => 9)
  end
  
  def buddhist_book_sub_1
    @articles = Article.get_all_buddhist_book_sub_1_blogs.paginate(:page => params[:page], :per_page => 4)
  end
  
  def buddhist_book_sub_2
    @articles = Article.get_all_buddhist_book_sub_2_blogs.paginate(:page => params[:page], :per_page => 4)
  end
  
  def buddhist_book_sub_3
    @articles = Article.get_all_buddhist_book_sub_3_blogs.paginate(:page => params[:page], :per_page => 4)
  end
  
  def buddhist_book_sub_4
    @articles = Article.get_all_buddhist_book_sub_4_blogs.paginate(:page => params[:page], :per_page => 4)
  end
  
  def buddhist_book_sub_5
    @articles = Article.get_all_buddhist_book_sub_5_blogs.paginate(:page => params[:page], :per_page => 4)
  end
end
