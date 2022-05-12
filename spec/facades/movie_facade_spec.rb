require 'rails_helper'

RSpec.describe MovieFacade do

  it 'initializes a TmdbService' do
    expect(MovieFacade.service).to be_a TmdbService
  end

  it 'collects data for to_20 movies', :vcr do
    results = MovieFacade.top_movies_data
    expect(results).to be_an Array
    expect(results[0][:title]).to eq('The Shawshank Redemption')
    expect(results[0][:vote_average]).to eq(8.7)
  end

  it 'creates 20 top movies objects' do
    json = File.read('spec/fixtures/top_20.json')
    data = JSON.parse(json, symbolize_names: true)[:results]
    results = MovieFacade.top20(data)
    expect(results).to be_an Array
    expect(results).to be_all MovieBrief
    expect(results[0]).to be_a MovieBrief
    expect(results[0].title).to eq('The Shawshank Redemption')
    expect(results[0].vote_average).to eq(8.7)
  end

  it 'creates 40 movies from valid search', :vcr do
    results = MovieFacade.search('man')

    expect(results).to be_an Array
    expect(results).to be_all MovieBrief
    expect(results.count).to eq(40)
    expect(results[0].title).to eq("The King's Man")
    expect(results[0].vote_average).to eq(6.9)
  end
end
