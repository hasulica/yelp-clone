require 'spec_helper'

describe Restaurant, type: :model do

  it { is_expected.to have_many :reviews }

  it 'is not valid unless it has a unique name' do
    Restaurant.create(name: 'Five Guys')
    restaurant = Restaurant.new(name: 'Five Guys')
    expect(restaurant).to have(1).error_on :name
  end

end
