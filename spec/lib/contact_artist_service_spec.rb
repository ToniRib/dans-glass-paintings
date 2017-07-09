require 'rails_helper'

describe ContactArtistService do
  describe '#generate_request' do
    let(:name) { 'Sam Carter' }
    let(:email) { 'samcarter@sg1.gov' }
    let(:message) { 'Request painting of the Stargate' }
    let(:mock_mailer) { instance_double(ActionMailer::MessageDelivery) }

    subject { described_class.new(name: name, email: email, message: message) }

    context 'when there are no errors' do
      it 'creates a new user request' do
        expect { subject.generate_request }.to change { UserRequest.count }.by 1
      end

      it 'returns true' do
        expect(subject.generate_request).to be true
      end

      it 'has an empty errors array' do
        subject.generate_request

        expect(subject.errors).to be_empty
      end

      it 'sends an email to the artist' do
        expect(ContactMailer)
          .to receive(:send_message)
            .with(name: name, email: email, message: message)
            .and_return(mock_mailer)
        expect(mock_mailer).to receive(:deliver_now)

        subject.generate_request
      end
    end

    context 'when there are errors' do
      let(:email) { 'notavalidemail' }

      it 'does not create a new user request' do
        expect { subject.generate_request }.not_to change { UserRequest.count }
      end

      it 'returns false' do
        expect(subject.generate_request).to be false
      end

      it 'does not send an email to the artist' do
        expect(ContactMailer).not_to receive(:send_message)

        subject.generate_request
      end

      it 'allows the errors to be accessed' do
        subject.generate_request

        expect(subject.errors).to contain_exactly 'Email is invalid'
      end
    end
  end
end
