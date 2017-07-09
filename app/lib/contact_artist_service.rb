class ContactArtistService
  def initialize(name:, email:, message:)
    @name = name
    @email = email
    @message = message
  end

  def generate_request
    @user_request = UserRequest.new(name: name, email: email, message: message)

    if user_request.save
      ContactMailer.send_message(name: name, email: email, message: message).deliver_now

      true
    else
      false
    end
  end

  def errors
    user_request.errors.full_messages
  end

  private
  attr_reader :name, :email, :message, :user_request
end
