class MovieFacade
  def top20(data = top_movies_data)
    data.map do |movie_data|
      MovieBrief.new(movie_data)
    end
  end

  def movie_data(id)
    search_movie_details(id)
    search_cast(id)
    search_reviews(id)
    movie = MovieBrief.new(@detailed_data)
    results = Hash.new
    results[:details] = movie.get_details(@detailed_data)
    results[:cast] = movie.get_cast(@cast_data)
    results[:reviews] = movie.get_reviews(@reviews_data)
    results
  end
  def search(keyword)
    search_movies_data(keyword)
    if @first_20[:total_pages] == 0
      "No movies found containing '#{keyword}'"
    else
      data = @first_20[:results] + @second_20[:results]
      data.map do |movie_data|
        MovieBrief.new(movie_data)
      end
    end
  end

  def search_movie_details(id)
    @detailed_data ||= service.detailed_data(id)
  end

  def search_cast(id)
    @cast_data ||= service.cast_data(id)
  end

  def search_reviews(id)
    @reviews_data ||= service.reviews_data(id)
  end
  def search_movies_data(keyword)
    @first_20 ||= service.search(keyword)
    @second_20 ||= service.search(keyword, 2)
  end

  def top_movies_data
    @top_movies_data ||= service.top20
  end

  def service
    @service ||= TmdbService.new
  end
end
