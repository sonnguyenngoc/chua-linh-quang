class ContactController < ApplicationController
  def index
    @contact = Contact.new
    @info = Company.get_pagoda_info
  end
  def send_contact_success
  end
end
