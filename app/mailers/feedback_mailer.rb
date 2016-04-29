class FeedbackMailer < ApplicationMailer
  default from: 'dacsanvungmien.net@gmail.com'
  
  def feedback_email(feedback)
    @feedback = feedback
    mail(to: "dacsanvungmien.net@gmail.com", subject: "Feeback - Đặc sản vùng miền")
  end
end
