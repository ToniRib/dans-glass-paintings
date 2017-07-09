require 'rails_helper'

describe 'Guest contacts the artist' do
  context 'with valid params' do
    scenario 'sends an email' do
      visit contact_path

      fill_in 'name', with: 'Toni Rib'
      fill_in 'email', with: 'testemail@example.com'
      fill_in 'message', with: "I'd like a new painting!"
      click_on 'Send'

      expect(page).to have_content('Your message has been sent!')
    end
  end

  context 'with invalid params' do
    scenario 'displays the errors' do
      visit contact_path

      fill_in 'name', with: 'Toni Rib'
      fill_in 'email', with: 'bademail@example'
      fill_in 'message', with: "I'd like a new painting!"
      click_on 'Send'

      expect(page).to have_content('Email is invalid')
    end
  end
end
