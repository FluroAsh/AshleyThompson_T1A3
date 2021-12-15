class Movie
    def initialize(selected_movie, imdb_id)
        @selected_movie = selected_movie
        @movie_info = []
        @imdb_id = imdb_id
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

    def display_md
        system("clear")

        # Movie Overview
        table = Terminal::Table.new :headings => 
        [
            "Title".colorize(:magenta), 
            "Year".colorize(:magenta),
            "Rating".colorize(:magenta),
            "Release Date".colorize(:magenta),
            "Runtime".colorize(:magenta),
            "Director".colorize(:magenta),
            "Genre".colorize(:magenta),
            "Actors".colorize(:magenta),
            "Awards".colorize(:magenta)
            ] do |t|
                t << [
                    @api_json["Title"].colorize(:cyan), 
                    @api_json["Year"].colorize(:yellow),
                    @api_json["Rated"].colorize(:yellow),
                    @api_json["Released"].colorize(:yellow),
                    @api_json["Runtime"].colorize(:yellow),
                    @api_json["Director"].colorize(:yellow),
                    @api_json["Genre"].colorize(:yellow),
                    @api_json["Actors"].colorize(:yellow),
                    @api_json["Awards"].colorize(:yellow)
                ]
            end
            puts table
           
            puts "Plot".underline
            puts @api_json["Plot"]
        
        # Ratings Table
        puts ""
        puts "Ratings".underline

        ratings = []
        @api_json["Ratings"].each_with_index { |e| ratings << e.values}

        table2 = Terminal::Table.new :headings => 
        [
            "IMDB Rating".colorize(:magenta),
            "Rotten Tomatoes".colorize(:magenta),
            "Metascore".colorize(:magenta),
            "Metacritic".colorize(:magenta)    
            ] do |t|
                t << [ 
                    @api_json["imdbRating"].colorize(:green),
                    ratings[1][1].colorize(:yellow), 
                    @api_json["Metascore"].colorize(:yellow), 
                    ratings[2][1].colorize(:yellow) 
                ]
            end

            puts table2
        
        #     raise StandardError if @api_json["Response"] == "False"
        # rescue StandardError
        #     puts "Error occured, no response from API".colorize(:red)
        #     sleep 2
        #     exit
        # end

    end

    def favourite_movie; end
end