class Question < ActiveRecord::Base
  validates :name, :email, :content, presence: true
  belongs_to :product
end
