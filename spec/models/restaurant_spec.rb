require 'spec_helper'

describe Restaurant, type: :model do
  it { is_expected.to have_many :reviews }

  it 'is not valid unless it has a unique name' do
    Restaurant.create(name: 'Five Guys')
    restaurant = Restaurant.new(name: 'Five Guys')
    expect(restaurant).to have(1).error_on :name
  end

  describe '#average_rating' do
    context 'no reviews' do
      it 'returns "N/A" when there are no reviews' do
        restaurant = Restaurant.create(name: 'The Ivy')
        expect(restaurant.average_rating).to eq 'N/A'
      end
    end

    context '1 review' do
      it 'returns that rating' do
        restaurant = Restaurant.create(name: 'The Ivy')
        restaurant.reviews.create(rating: 4)
        expect(restaurant.average_rating).to eq 4
      end
    end

    context 'multiple reviews' do
      # it 'returns the average' do
      #   restaurant = Restaurant.create(name: 'The Ivy')
      #   restaurant.reviews.create(rating: '1', user_id: 1)
      #   restaurant.reviews.create(rating: '5', user_id: nil)
      #   expect(restaurant.average_rating).to eq 3
      # end
    end
  end
end
