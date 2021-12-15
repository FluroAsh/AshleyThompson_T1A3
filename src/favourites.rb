class Favourites
    def initialize(username, title, year)
        @username = username
        @file_path = "./lib/favourites.json"
        @title = title
        @year = year
        
    end

    # reading and writing to favourites.txt will happen here

    def parse_JSON
        # Parse existing JSON so we can use it 
        # in our save_favourite & display_favourites methods
    end

    def save_favourite 
        # Save movie.title & movie.year into favourites.JSON
        puts "::: You're in save_favourite"
    end


    def display_favourites
        puts "::: You're in display_favourites"
    end
end