class User < ActiveRecord::Base
  validates :email, uniqueness: true
  belongs_to :area, foreign_key: "province"
  has_many :wish_lists
  
  has_many :orders
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

end
