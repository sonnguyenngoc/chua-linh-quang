class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :user
  
  after_create :touch_conversation
  
  validates_presence_of :body, :conversation_id, :user_id
  
  def self.lastest_message
    self.order("created_at DESC").first
  end
  
  def touch_conversation
    conversation.update_column(:updated_at, Time.now)
  end
  
  
end