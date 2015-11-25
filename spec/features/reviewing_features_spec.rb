require 'spec_helper'

feature 'Reviewing' do
  before { Restaurant.create name: 'Bocado' }

  context 'User logged in' do
    scenario 'Allow users to leave a review using a form' do
      login
      visit '/restaurants'
      click_link 'Review Bocado'
      fill_in 'Thoughts', with: 'Okay'
      select '3', from: 'Rating'
      click_button 'Leave Review'
      expect(current_path).to eq '/restaurants'
      expect(page).to have_content 'Okay'
    end

    scenario 'User cannot review a restaurant it has already reviewed' do
      login
      visit '/restaurants'
      click_link 'Review Bocado'
      fill_in 'Thoughts', with: 'Okay'
      select '3', from: 'Rating'
      click_button 'Leave Review'
      click_link 'Review Bocado'
      expect(current_path).to eq '/restaurants'
      expect(page).to have_content 'You already reviewed this restaurant'
    end
  end

  context 'User not logged in' do
    scenario 'Cannot review a restaurant' do
      visit '/restaurants'
      click_link 'Review Bocado'
      expect(current_path).to eq '/users/sign_in'
    end
  end
end
