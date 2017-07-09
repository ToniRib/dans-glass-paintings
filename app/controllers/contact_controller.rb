class ContactController < ApplicationController
  def new
    render :new, locals: { errors: [] }
  end

  def create
    contact_artist_service = ContactArtistService.new(user_request_params)

    if contact_artist_service.generate_request
      redirect_to contact_path, notice: 'Your message has been sent!'
    else
      render :new, locals: { errors: contact_artist_service.errors }
    end
  end

  private

  def user_request_params
    {
      name:    params[:name],
      email:   params[:email],
      message: params[:message],
    }
  end
end
