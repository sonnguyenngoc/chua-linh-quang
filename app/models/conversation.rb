class Conversation < ActiveRecord::Base
  belongs_to :sender, :foreign_key => :sender_id, class_name: 'User'
  belongs_to :recipient, :foreign_key => :recipient_id, class_name: 'User'

  has_many :messages, dependent: :destroy

  validates_uniqueness_of :sender_id, :scope => :recipient_id

  scope :involving, -> (user) do
    where("conversations.sender_id =? OR conversations.recipient_id =?",user.id,user.id)
  end

  scope :between, -> (sender_id,recipient_id) do
    where("(conversations.sender_id = ? AND conversations.recipient_id =?) OR (conversations.sender_id = ? AND conversations.recipient_id =?)", sender_id,recipient_id, recipient_id, sender_id)
  end
  
  def get_new_message
    message = self.messages.order("created_at DESC").first
    if message.nil?
        return Message.create(body: "Chưa có nội dung chat...")
    else
        return message
    end
  end
  def get_chatter(current_user)
    if current_user.present?
        if sender_id == current_user.id
            return recipient
        end
        if sender_id != current_user.id
            return sender
        end
    end
  end
  
  
end
