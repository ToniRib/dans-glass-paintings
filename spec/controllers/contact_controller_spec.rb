require 'rails_helper'

describe ContactController, type: :controller do
  describe 'GET #new' do
    it 'returns a successful HTTP status' do
      get :new

      expect(response).to be_successful
    end

    it 'returns a 200 HTTP status code' do
      get :new

      expect(response.status).to eq 200
    end
  end

  describe 'POST #create' do
    let(:name) { 'Toni Rib' }
    let(:email) { 'toni@example.com' }
    let(:message) { 'New Painting' }
    let(:generation_response) { true }
    let(:errors) { [] }
    let(:mock_contact_service) do
      double(ContactArtistService, generate_request: generation_response, errors: errors)
    end

    before do
      allow(ContactArtistService).to receive(:new).and_return(mock_contact_service)
    end

    it 'calls the ContactArtistService with the form params' do
      expect(ContactArtistService).to receive(:new)
        .with(name: name, email: email, message: message)
        .and_return(mock_contact_service)
      expect(mock_contact_service).to receive(:generate_request)

      post :create, params: { name: name, email: email, message: message }
    end

    context 'when the contact artist service succeeds' do
      it 'redirects to the new request page' do
        post :create, params: { name: name, email: email, message: message }

        expect(response).to redirect_to contact_path
      end

      it 'displays a success notice' do
        post :create, params: { name: name, email: email, message: message }

        expect(flash[:notice]).to eq 'Your message has been sent!'
      end
    end

    context 'renders the new request page' do
      let(:generation_response) { false }
      let(:errors) { ['Email is invalid'] }

      it 're-renders the new request page' do
        post :create, params: { name: name, email: email, message: message }

        expect(response).to render_template :new
      end
    end
  end
end
