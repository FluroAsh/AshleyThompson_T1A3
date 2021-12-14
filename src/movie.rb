class Movie
    def initialize(selected_movie)
        @selected_movie = selected_movie
        @movie_info = []
        @imdb_id = ""
    end

    # Movie selection and display methods will go here

    # Requires the IMDB ID to get additional information such as actors, writers, release date etc.
    
    def fetch_items # what if there's no results?
        
        url = URI("https://movie-database-imdb-alternative.p.rapidapi.com/?i=" + @imdb_id + "&r=json")

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        request = Net::HTTP::Get.new(url)
        request["x-rapidapi-host"] = 'movie-database-imdb-alternative.p.rapidapi.com'
        request["x-rapidapi-key"] = '95bf4e37b4mshe8cb692a716b2e3p190df5jsnb5e4f313f0e0'
        @response = http.request(request)
    end

    def parse_JSON
        @api_json = JSON.parse(@response.read_body)
    end

    def add_items 
        # Will need to add all the specific fields to an array for later use
    end
end