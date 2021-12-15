require_relative './lib/environment'

## ARGV's go here

# Main Menu
while true  # Loops until we run into menu = false
    system("clear")
    User.welcome
    login_register = PROMPT.select("Menu".underline, %w(Login Register Exit))

    case login_register # To do fix so there's a delay before exiting loop
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
            movie_items.add_items
            
            movie_items.display_items
            movie_items.select_movie
            imdb_id = movie_items.get_imdbID
            
            movie = Movie.new(movie_items.selected_movie, imdb_id)
            movie.fetch_items
            movie.parse_JSON
            movie.display_md
            puts "" 

            favourite = Favourites.new(user.username, movie.title, movie.year)

            display_add = PROMPT.select("Favourites".underline) do |menu|
                puts ""
                menu.choice "Display", -> { favourite.display_favourites }
                menu.choice "Add", -> { favourite.save_favourite }
                menu.choice "Retry", -> { break }
                menu.choice "Exit", -> { exit } 
            end
        end 
        puts ""
        search_exit = PROMPT.select("Search again?".underline) do |menu|
            menu.choice "Yes"
            menu.choice "No", -> { exit } 
            menu.choice "Logout", -> { user.logout } 
        end
        # Search again? 
        # if choice == "No" then exit
        # if choice == "Yes" then do nothing 
    end
end