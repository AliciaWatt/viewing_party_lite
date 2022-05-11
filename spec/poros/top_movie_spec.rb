require 'rails_helper'

RSpec.describe TopMovie do
  it 'exists' do
    data = {
      title: "The Shawshank Redemption",
      vote_average: 8.7
    }
    top_movie = TopMovie.new(data)

    expect(top_movie).to be_instance_of(TopMovie)
    expect(top_movie.title).to eq("The Shawshank Redemption")
    expect(top_movie.vote_average).to eq(8.7)
  end
end
