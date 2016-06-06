class User < ActiveRecord::Base
    validates :email, uniqueness: true
    validates :email, :first_name, :last_name, :phone, :address_1, :country, :province, presence: true
    
    belongs_to :area, foreign_key: "province"
    has_many :wish_lists, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :conversations, :foreign_key => :sender_id, dependent: :destroy
    has_many :messages, dependent: :destroy
    belongs_to :user_group
    
    
    has_many :orders, dependent: :destroy
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :omniauthable, :validatable,
           :omniauthable, :lastseenable
           
    def ability
        @ability ||= Ability.new(self)
    end
    delegate :can?, :cannot?, :to => :ability
    
    def self.find_for_facebook(access_token, signed_in_resource=nil)
        data = access_token.info
        user = User.where(:provider => access_token.provider, :uid => access_token.uid ).first
        if user
            return user
        else
            registered_user = User.where(:email => access_token.info.email).first
            if registered_user
                return registered_user
            else
                user = User.create(
                    first_name: data["name"],
                    provider:access_token.provider,
                    email: data["email"],
                    uid: access_token.uid,
                    oauth_token: access_token.credentials.token,
                    oauth_expires_at: Time.at(access_token.credentials.expires_at),
                    password: Devise.friendly_token[0,20],
                )
            end
       end
    end
    
    def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
        data = access_token.info
        user = User.where(:provider => access_token.provider, :uid => access_token.uid ).first
        if user
            return user
        else
            registered_user = User.where(:email => access_token.info.email).first
            if registered_user
                return registered_user
            else
                user = User.create(
                    first_name: data["first_name"],
                    last_name: data["last_name"],
                    provider:access_token.provider,
                    email: data["email"],
                    uid: access_token.uid,
                    oauth_token: access_token.credentials.token,
                    oauth_expires_at: Time.at(access_token.credentials.expires_at),
                    password: Devise.friendly_token[0,20],
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
            last_name.to_s + " " + first_name.to_s.split(" ").first
        else
            email.gsub(/@(.+)/,'')
        end
    end
    
    def self.sort_by
        [
            [I18n.t('created_at'), "users.created_at"]
        ]
    end
    
    def self.sort_order
        [
            [I18n.t('asc'),"asc"],
            [I18n.t('desc'),"desc"],
        ]
    end
    
    def self.display_name
        self.first_name.to_s + " " + self.last_name.to_s
    end
    
    def self.search(params)
        records = self.all
        
        if params[:area_id].present?
            records = records.where(area_id: params[:area_id])
        end
        
        #Search keyword filter
        if params[:keyword].present?
            records = records.where("LOWER(CONCAT(users.first_name,' ',users.last_name,' ',users.email,' ',users.phone,' ',users.address_1,' ',users.address_2)) LIKE ?", "%#{params[:keyword].downcase.strip}%")
        end
        
        # for sorting
        sort_by = params[:sort_by].present? ? params[:sort_by] : "users.created_at"
        sort_order = params[:sort_order].present? ? params[:sort_order] : "asc"
        records = records.order("#{sort_by} #{sort_order}")
        
        return records
    end
    
    def self.get_online_users
        self.where("last_seen > ?", 2.minutes.ago )
    end
    
    def saw
        self.update_column(:last_seen, Time.now)
    end
    
    def self.get_users
        self.where("is_admin = ?", false)
    end
    
    def self.get_admins
        self.where("is_admin = ?", true)
    end
    
    def self.get_online_admins
        self.where("is_admin = ? and last_seen > ?", true, 2.minutes.ago)
    end
    
    def display_user_name
        self.first_name.to_s + " " + self.last_name.to_s
    end
    
    def involving_conversations
        Conversation.where("conversations.sender_id =? OR conversations.recipient_id =?",self.id,self.id)
    end
    
    def sent_messages
    end
    
    def received_messages
      records = Message.joins(:conversation)
                .where("conversations.sender_id =? OR conversations.recipient_id =?", self.id, self.id)
                .where.not(user_id: self.id)
    end
    
    def unread_messages(params=nil)
        records = received_messages.where(seen: nil)
        if params.present? and params[:conversation_id].present?
            records = records.where(conversation_id: params[:conversation_id])
        end
        
        return records
    end
    
    def unread_conversations_count
        unread_messages.group("conversations.id").distinct.count("conversations.id").count
    end
    
    def see(c)
        c.messages.where.not(user_id: self.id).update_all(seen: Time.now)
    end
    
    def self.get_role_options
        [
            [I18n.t('user'), 'user'],
            [I18n.t('manager'), 'manager'],
            [I18n.t('admin'), 'admin'],
        ]
    end
    
    def permissions
        user_group.permissions
    end
    
    def permission(model, action)
        return ['no'] if user_group.nil?
        user_group.ability(model, action)
    end
end
