require_relative './lib/environment'

## ARGV's go here

# Main Menu
while true  # Loops until user tells the application to 'exit'
    system("clear")
    User.welcome
    login_register = PROMPT.select("Menu".underline, %w(Login Register Exit))

    case login_register
    when "Login"
        system("clear")
        username = User.get_username
        password = User.get_password
        user = User.new(username, password)
        
        user.validate_login
            
    when "Register"
        system("clear")
        username = User.get_username
        password = User.get_password
        user = User.new(username, password)
        
        user.save_login
              
    when "Exit"
        exit 
    end

    PROMPT.keypress("(Press space or enter to continue)".colorize(:green), keys: [:space, :return])

    # Search Menu(s)
    while user.logged_in
        system("clear")
        movie_items = MovieItems.new(user.search_movie)

        unless user.search_title.size < 3 || user.search_title.start_with?("%20")
            movie_items.fetch_items
            movie_items.parse_JSON

            if movie_items.add_items == "False"
                next
            end
            
            movie_items.display_items
            movie_items.select_movie
            imdb_id = movie_items.get_imdbID
            
            movie = Movie.new(movie_items.selected_movie, imdb_id)
            movie.fetch_items
            movie.parse_JSON
            movie.display_md

            favourite = Favourites.new(user.username, movie.title, movie.year)
            
            puts ""
            PROMPT.select("Favourites".underline) do |menu|
                menu.choice "Display", -> { favourite.display_favourites }
                menu.choice "Add", -> { favourite.save_favourite }
                menu.choice "Exit", -> { exit } 
            end
        end 
        
        
        # TODO: Don't execute this loop if we're retrying a search
        # ()
        puts "" 
            PROMPT.select("Search again?".underline) do |menu|
            menu.choice "Yes"
            menu.choice "Exit", -> { exit } 
            menu.choice "Logout", -> { user.logout } 
        end 
    end
end