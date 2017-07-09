class ContactController < ApplicationController
  def show
  end

  def create
    ContactMailer.send_message(email_params).deliver_now

    redirect_to contact_path, notice: 'Your message has been sent!'
  end

  private

  def email_params
    {
      name:    params[:name],
      email:   params[:email],
      message: params[:message],
    }
  end
end
