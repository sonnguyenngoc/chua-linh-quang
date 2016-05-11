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
           
    def send_password_reset
        generate_token(:password_reset_token)
        self.password_reset_sent_at = Time.zone.now
        save!
        UserMailer.password_reset(self).deliver_now
    end
end
