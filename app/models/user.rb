class User < ActiveRecord::Base
  validates :email, uniqueness: true
  validates :first_name, :last_name, :email, :phone, :address_1, :password, :password_confirmation, presence: true
  belongs_to :area, foreign_key: "province"
  has_many :wish_lists
  
  has_many :orders
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

end
