def login
  visit '/users/sign_up'
  fill_in 'Email', with: 'user@test.co.uk'
  fill_in 'Password', with: 'password'
  fill_in 'Password confirmation', with: 'password'
  click_button 'Sign up'
end
