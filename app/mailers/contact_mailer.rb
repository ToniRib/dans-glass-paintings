class ContactMailer < ActionMailer::Base
  default to: "danribla@gmail.com"
  default template_path: "mailers/contact_mailer"

  def send_message(name:, email:, message:)
    subject = "Dan's Glass Paintings: New message from #{name}"

    @name = name
    @message = message
    @email = email

    mail subject: subject, from: email
  end
end
