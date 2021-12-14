require_relative './lib/environment'

class MovieItems
    def initialize(movie_title)
        @movie_items = Hash.new
        @selected_movie = movie_title
    end

    # API Methods will go in here
end