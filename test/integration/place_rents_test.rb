require 'test_helper'

class PlaceRentsTest < ActionDispatch::IntegrationTest
  
  setup do
    user_login
  end

  test "user rents a place on parking" do
    visit parkings_url
    click_link('Rent a place', match: :first)
    within('form#new_place_rent') do
      select('2015', from: 'place_rent_starts_at_1i')
      select('June', from: 'place_rent_starts_at_2i')
      select('20', from: 'place_rent_starts_at_3i')
      select('01 PM', from: 'place_rent_starts_at_4i')
      # select('00', from: 'place_rent_starts_at_5i')

      select('2015', from: 'place_rent_ends_at_1i')
      select('July', from: 'place_rent_ends_at_2i')
      select('20', from: 'place_rent_ends_at_3i')
      select('01 PM', from: 'place_rent_ends_at_4i')

      select('Honda - 44-432', from: 'Car')

      click_button 'Create Place rent'
    end
    assert has_content?('You have successfully rented the place.')
  end

  test "price is displayed on the place rents list" do
    visit parkings_url
    assert has_content?('Price')
  end
end
