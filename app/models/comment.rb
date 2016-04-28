class Comment < ActiveRecord::Base
  validates :name, :content, :star, presence: true
  belongs_to :product
  belongs_to :user
end
