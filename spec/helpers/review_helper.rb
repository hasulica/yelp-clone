def leave_review(thoughts, rating)
  visit '/'
  click_link 'Review Bocado'
  fill_in 'Thoughts', with: thoughts
  select rating, from: 'Rating'
  click_button 'Leave Review'
end
