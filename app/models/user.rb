class User < ActiveRecord::Base
    validates :email, uniqueness: true
    validates :first_name, :last_name, :email, :phone, :address_1, :password, :password_confirmation, presence: true
    belongs_to :area, foreign_key: "province"
    has_many :wish_lists
    has_many :comments, dependent: :destroy
    
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
    
    def self.new_with_session(params, session)
        super.tap do |user|
            if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
                user.email = data["email"] if user.email.blank?
            end
        end
    end
    
    def short_name
        if !first_name.nil?
            last_name + " " + first_name.split(" ").first
        else
            email.gsub(/@(.+)/,'')
        end
    end
    
    def self.sort_by
        [
            ["Created At", "users.created_at"]
        ]
    end
    
    def self.sort_order
        [
            ["ASC","asc"],
            ["DESC","desc"],
        ]
    end
    
    def self.search(params)
        records = self.all
        
        #Search keyword filter
        if params[:keyword].present?
            records = records.where("LOWER(concat(users.first_name,' ',users.last_name,' ',users.email,' ',users.phone,' ',users.address_1,' ',users.address_2)) LIKE ?", "%#{params[:keyword].downcase.strip}%")
        end
        
        # for sorting
        sort_by = params[:sort_by].present? ? params[:sort_by] : "users.created_at"
        sort_order = params[:sort_order].present? ? params[:sort_order] : "asc"
        records = records.order("#{sort_by} #{sort_order}")
        
        return records
    end
end
