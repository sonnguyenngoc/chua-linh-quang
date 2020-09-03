# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://chualinhquang.com.vn"

SitemapGenerator::Sitemap.create do
  add hot_news_path
  add gallery_picture_path
  add gallery_music_path
  add gallery_video_path
  add contact_path
  Article.get_active_articles.each do |article|
    add post_detail_path(category_id: article.article_categories.first, category_name: article.article_categories.first, post_id: article.id, post_name: article.url_friendly)
  end
  
  ArticleCategory.all.each do |category|
    add category_path(category_id: category, category_name: category.url_friendly)
  end
  
  Gallery.get_all_galleries.each do |gallery|
    add picture_detail_path(picture_id: gallery.id, picture_name: gallery.url_friendly)
  end
  
end
