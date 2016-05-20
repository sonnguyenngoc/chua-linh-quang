class ConversationsController < ApplicationController
  before_filter :authenticate_user!, except: [:chat_box, :quick_register]

  layout false

  def create
    if Conversation.between(params[:sender_id],params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id],params[:recipient_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end

    render json: { conversation_id: @conversation.id }
  end

  def show
    @conversation = Conversation.find(params[:id])
    @reciever = interlocutor(@conversation)
    @messages = @conversation.messages
    @message = Message.new
    
    current_user.see(@conversation)
    @path = conversation_path(@conversation)
  end
  
  def chat_box
  end
  
  def quick_register
    generated_password = Devise.friendly_token.first(8)
    user = User.create!(:first_name => params[:user][:first_name], :email => params[:user][:email], :password => generated_password)
    sign_in(:user, user)
    
    redirect_to chat_box_path(new_user: true)
  end

  private
  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end

  def interlocutor(conversation)
    current_user == conversation.recipient ? conversation.sender : conversation.recipient
  end
end