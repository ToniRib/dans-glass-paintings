require 'rails_helper'

describe ContactController, type: :controller do
  describe 'GET #show' do
    it 'returns a successful HTTP status' do
      get :show

      expect(response).to be_successful
    end

    it 'returns a 200 HTTP status code' do
      get :show

      expect(response.status).to eq 200
    end
  end

  describe 'POST #create' do
    let(:name) { 'Toni Rib' }
    let(:email) { 'toni@example.com' }
    let(:message) { 'New Painting' }
    let(:mock_mailer) { instance_double(ActionMailer::MessageDelivery) }

    it 'redirects to the contact show page' do
      post :create, params: { name: name, email: email, message: message }

      expect(response).to redirect_to contact_path
    end

    it 'displays a notice' do
      post :create, params: { name: name, email: email, message: message }

      expect(flash[:notice]).to eq 'Your message has been sent!'
    end

    it 'calls the ContactMailer with the form params' do
      expect(ContactMailer)
        .to receive(:send_message)
          .with(name: name, email: email, message: message)
          .and_return(mock_mailer)
      expect(mock_mailer).to receive(:deliver_now)

      post :create, params: { name: name, email: email, message: message }
    end
  end
end
