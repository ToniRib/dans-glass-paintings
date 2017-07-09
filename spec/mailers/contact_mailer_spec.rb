require 'rails_helper'

describe ContactMailer do
  describe '#send_message' do
    let(:name) { 'Toni Rib' }
    let(:email) { 'toni@example.com' }
    let(:message) { 'New Painting' }

    it 'sends an email' do
      expect { described_class.send_message(name: name, email: email, message: message).deliver_now }
        .to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it 'sends it to the correct address' do
      mail = described_class.send_message(name: name, email: email, message: message).deliver_now

      expect(mail.to).to contain_exactly 'danribla@gmail.com'
    end

    it 'sends it from the person who sent the request' do
      mail = described_class.send_message(name: name, email: email, message: message).deliver_now

      expect(mail.from).to contain_exactly email
    end

    it 'includes the name in the subject' do
      mail = described_class.send_message(name: name, email: email, message: message).deliver_now

      expect(mail.subject).to eq "Dan's Glass Paintings: New message from #{name}"
    end
  end
end
