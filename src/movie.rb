class Movie
    def initialize(title, year, imdb_rating, runtime, genre, directors, plot)
        @title = title
        @year = year
        @IMDB_rating = imdb_rating
        @runtime = runtime
        @genre = genre
        @directors = directors
        @plot = plot
        @favorite = "" # Favorite.new(@Title, @Year)
    end

    # Movie selection and display methods will go here

    # Requires the IMDB ID to get additional information such as actors, writers, release date etc.
end