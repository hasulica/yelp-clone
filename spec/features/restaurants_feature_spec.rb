require 'rails_helper'

feature 'restaurant' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet!'
      expect(page).to have_link 'Add a restaurant!'
    end
  end
  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'KFC')
    end
    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do
    context 'user logged in' do
      scenario 'prompt a user to fill out a form, the display the new restaurant' do
        login('test@test.com')
        visit '/restaurants'
        click_link 'Add a restaurant!'
        fill_in 'Name', with: 'KFC'
        click_button 'Create Restaurant'
        expect(page).to have_content 'KFC'
        expect(current_path).to eq '/restaurants'
      end

      context 'invalid restaurant' do
        it 'does not allow user to submit name that is too short' do
          login('test@test.com')
          visit '/restaurants'
          click_link 'Add a restaurant!'
          fill_in 'Name', with: 'kf'
          click_button 'Create Restaurant'
          expect(page).not_to have_css 'h2', text: 'kf'
          expect(page).to have_content 'error'
        end
      end
    end

    context 'no user logged in' do
      scenario 'when adding restaurant, prompt to sign up or sign in' do
        visit '/restaurants'
        click_link 'Add a restaurant'
        expect(current_path).to eq '/users/sign_in'
      end
    end
  end

  context 'viewing restaurants' do
    let!(:kfc){Restaurant.create(name: 'KFC')}
    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context 'editing restaurants' do
    context 'user logged in' do
      before do
        Restaurant.create name: 'KFC'
        login('test@test.com')
      end
      scenario 'let a user edit a restaurant' do
        visit '/restaurants'
        click_link 'Edit KFC'
        fill_in 'Name', with: 'Kentucky Fried Chicken'
        click_button 'Update Restaurant'
        expect(page).to have_content 'Kentucky Fried Chicken'
        expect(current_path).to eq '/restaurants'
      end
    end
    context 'user not logged in' do
      before { Restaurant.create name: 'KFC' }

      scenario 'let a user edit a restaurant' do
        visit '/restaurants'
        expect(page).not_to have_css 'a', text: 'Edit KFC'
      end
    end
  end

  context 'deleting restaurants' do
    context 'user logged in' do
      before do
        Restaurant.create name: 'KFC'
        login('test@test.com')
      end

      scenario 'removes a restaurant when a user clicks a delete link' do
        visit '/restaurants'
        click_link 'Delete KFC'
        expect(page).not_to have_content 'KFC'
        expect(page).to have_content 'Restaurant deleted successfully'
      end
    end
    context 'user not logged in' do
      before do
        Restaurant.create name: 'KFC'
      end

      scenario 'removes a restaurant when a user clicks a delete link' do
        visit '/restaurants'
        expect(page).not_to have_css 'a', text: 'Delete KFC'
      end
    end
  end
end
