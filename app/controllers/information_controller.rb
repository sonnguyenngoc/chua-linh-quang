class InformationController < ApplicationController
  def about_us
    @title_head = "Về chúng tôi"
    @lastest_blog_posts = Article.get_lastest_blog_posts
  end
  def contact_us
    @title_head = "Liên hệ"
    @lastest_blog_posts = Article.get_lastest_blog_posts
  end
end
