require 'rails_helper'

describe UserRequest, type: :model do
  describe 'validation' do
    it 'requires an email address' do
      expect(build(:user_request, email: nil)).not_to be_valid
    end

    it 'requires a name' do
      expect(build(:user_request, name: nil)).not_to be_valid
    end

    it 'requires a message' do
      expect(build(:user_request, message: nil)).not_to be_valid
    end

    it 'ensures the email address is valid' do
      expect(build(:user_request, email: 'hello')).not_to be_valid
    end

    it 'removes xss attacks' do
      user_request = create(:user_request, name: 'Toni Rib <script>alert("hi")</script>')

      expect(user_request.name).to eq 'Toni Rib alert(&quot;hi&quot;)'
    end
  end
end
