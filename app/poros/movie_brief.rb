class MovieBrief
  attr_reader :title, :vote_average, :id

  def initialize(data)
    @id = data[:id]
    @title = data[:title]
    @vote_average = data[:vote_average]
  end

  def get_details(detailed_data)
    results = Hash.new
    results[:title] = detailed_data[:title]
    results[:vote_average] = detailed_data[:vote_average]
    results[:genre] = detailed_data[:genres].collect {|genre| genre[:name]}
    results[:runtime] = "#{detailed_data[:runtime]/60}h #{detailed_data[:runtime] % 60}min"

    results[:summary] = detailed_data[:overview]
    results
  end

  def get_reviews(reviews_data)
    results = Hash.new 
    results[:review_count] = reviews_data[:total_results]
    results[:review_detail] = []
    reviews_data[:results].each_with_index do |review, index|
      results[:review_detail][index] = Hash.new
      results[:review_detail][index][:author] = review[:author]
      results[:review_detail][index][:content] = review[:content]
    end
    results
  end

  def get_cast(cast_data)
    results = []
    cast_data[:cast][0..9].each_with_index  {|cast, index| 
      results[index]= Hash.new
      results[index][:name] = cast[:name]
      results[index][:character] = cast[:character]
    }
    results
  end
end
