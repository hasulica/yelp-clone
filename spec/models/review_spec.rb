require 'spec_helper'

describe Review, type: :model do
  it { is_expected.to belong_to :restaurant }
  it { is_expected.to belong_to :user }

  it 'is invalid if rating if more than 5' do
    review = Review.new(rating: 10)
    expect(review).to have(1).error_on :rating
  end

  describe '#average_rating' do
    context 'no reviews' do
      it 'returns "N/A" when there are no reviews' do
        restaurant = Restaurant.create(name: 'The Ivy')
        expect(restaurant.average_rating).to eq 'N/A'
      end
    end
  end
end
