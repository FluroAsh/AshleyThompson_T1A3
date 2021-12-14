require_relative './lib/environment'

class MovieItems
    attr_reader :search_title, :movie_items

    def initialize(search_title)
        @search_title = search_title
        @movie_items = [] # Temp array to hold our search items
        @choices = []
        @selected_movie = nil
    end

    # API Methods will go in here
    # - fetch_items (from API) ✅
    # - parse_JSON
    # - add_items
    # - display_items
    # - select_movie

    def fetch_items # what if there's no results?
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
        # Appends whole hash minus "Search" to movie_items for later use
        @api_json["Search"].each do |e|
            @movie_items << e
        end

        # Takes values from @movie_items for use in tty-prompt choices
        @movie_items.each_with_index do |e, i|
            @choices << [
                @movie_items[i]["Title"], 
                @movie_items[i]["Year"]
            ]
        end
    end

    def display_items
        # Iterate through movie items

        @movie_items.each_with_index do |e, i|
            puts "#{@movie_items[i]["Title"]}, #{@movie_items[i]["Year"]}"
        end
        print @choices

        # print @movie_items[1]


        # Get the title & year to print for every element[0..] 
        # then using terminal table add new row for every new entry  
        #! Unless too diffuclt, then just focus on logic & skip TT
    end
end