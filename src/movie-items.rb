require_relative './lib/environment'

class MovieItems
    attr_reader :search_title, :movie_items, :choices, :selected_movie
    
    def initialize(search_title)
        @search_title = search_title
        @movie_items = [] # Temp array to hold our search items
        @choices = []
        @selected_movie = nil
    end

    def fetch_items # what if there's no results? "Response" => "False"?
        
        url = URI("https://movie-database-imdb-alternative.p.rapidapi.com/?s=" + search_title + "&page=1&r=json")

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
        # Appends whole api_json "Search" to movie_items for later use
        @api_json["Search"].each_with_index do |e, i|
            @movie_items << e unless @api_json["Search"][i]["Type"] == "series" || @api_json["Search"][i]["Type"] == "game"
        end

        # Takes values from @movie_items for use in tty-prompt choices
        @movie_items.each_with_index do |e, i|
            @choices << [@movie_items[i]["Title"]]
        end
        @choices << ["Exit"]
    end

    def display_items 
        table = Terminal::Table.new :headings => 
        ["Title".colorize(:magenta), "Year".colorize(:magenta)] do |t|
            @movie_items.each_with_index do |e, i|
                t << [@movie_items[i]["Title"].colorize(:cyan), @movie_items[i]["Year"].colorize(:yellow)]
            end
        end
        puts table
    end

    def select_movie
        @selected_movie = PROMPT.select("Select a Movie:", @choices)
        if @selected_movie == "Exit"
            exit
        end
        @selected_movie

    end

    def get_imdbID
        @movie_items.each_with_index do |e, i|
            if @selected_movie == @movie_items[i]["Title"]
                @imdb_ID = @movie_items[i]["imdbID"]
            end
        end
        @imdb_ID
    end
end