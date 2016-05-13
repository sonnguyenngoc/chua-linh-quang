class User < ActiveRecord::Base
    validates :email, uniqueness: true
    validates :first_name, :last_name, :email, :phone, :address_1, :password, :password_confirmation, presence: true
    belongs_to :area, foreign_key: "province"
    has_many :wish_lists
    
    has_many :orders
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]
           
    def send_password_reset
        generate_token(:password_reset_token)
        self.password_reset_sent_at = Time.zone.now
        save!
        UserMailer.password_reset(self).deliver_now
    end
    
    def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
        user = User.where(:provider => auth.provider, :uid => auth.uid).first
        if user
            return user
        else
            registered_user = User.where(:email => auth.info.email).first
            if registered_user
                return registered_user
            else
                user = User.create(
                                provider:auth.provider,
                                uid:auth.uid,
                                email:auth.info.email,
                                password:Devise.friendly_token[0,20],
                            )
            end    
        end
    end
    
    def self.from_omniauth(auth)
        where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
          user.email = auth.info.email
          user.password = Devise.friendly_token[0,20]
          user.first_name = auth.info.name   # assuming the user model has a name
        end
    end
    
    def self.new_with_session(params, session)
        super.tap do |user|
          if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
            user.email = data["email"] if user.email.blank?
          end
        end
    end
end
