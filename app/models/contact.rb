class Contact < ActiveRecord::Base
  validates :name, :phone, :email, :message, presence: true
  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
end
