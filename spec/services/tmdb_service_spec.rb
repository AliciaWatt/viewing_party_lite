require 'rails_helper'

RSpec.describe TmdbService do
  let!(:service) {TmdbService.new}

  it 'gets data for Top20 movies' do

  results = service.get_top20

  expect(results).to be_a Hash
  expect(results.count).to eq(20)
  expect(results)




  expect(page.status_code).to eq 200
  expect(page).to have_content("Senator Cory Booker was found!")
  expect(page).to have_content("SenBooker")
end
end
