class User < ActiveRecord::Base
    validates :email, uniqueness: true
    validates :first_name, :last_name, :email, :phone, :address_1, :password, :password_confirmation, presence: true
    belongs_to :area, foreign_key: "province"
    has_many :wish_lists
    
    has_many :orders
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :omniauthable, :validatable,
           :omniauthable, :omniauth_providers => [:facebook]
           
    def send_password_reset
        generate_token(:password_reset_token)
        self.password_reset_sent_at = Time.zone.now
        save!
        UserMailer.password_reset(self).deliver_now
    end
    
    def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.oauth_token = auth.credentials.token
        user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      end
  end
end
