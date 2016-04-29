class CommentArticle < ActiveRecord::Base
  validates :name, :email, :content, presence: true
  belongs_to :article
  belongs_to :user
end
