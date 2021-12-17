require_relative './lib/environment'

## Main Application
# Main Menu
while true  # Loops until user selects an exit menu.choice
    system("clear")
    User.welcome
    login_register = PROMPT.select("Menu".underline, %w(Login Register Exit))

    case login_register
    when "Login"
        system("clear")
        user = User.new(User.get_username, User.get_password)
        user.validate_login
            
    when "Register"
        system("clear")
        user = User.new(User.get_username, User.get_password)
        user.save_login
              
    when "Exit"
        exit 
    end

    PROMPT.keypress("(Press space or enter to continue)".colorize(:green), keys: [:space, :return])

    # Search Menu(s)
    while user.logged_in
        system("clear")
        movie_items = MovieItems.new
        
        puts "What movie are you looking for?".colorize(:cyan)
        print ">> ".colorize(:cyan)
        search_title = gets.chomp.strip.gsub(/\s+/, '%20') 
        
        unless search_title.size < 2 || search_title.start_with?("%20")
            movie_items.fetch_items(search_title)

            # Method returns "False" if nothing was added, 
            # Uses 'Next' to loop back into itself while user.logged_in == true
            if movie_items.add_items == "False" 
                next
            end
            
            movie_items.display_items
            movie_items.select_movie
            imdb_id = movie_items.get_imdbID
            movie = Movie.new(movie_items.selected_movie, imdb_id)
            
            movie.fetch_items
            system("clear")
            movie.display_md

            favourite = Favourites.new(user.username, movie.title, movie.year)
            favourite.parse_JSON
            
            puts 
            PROMPT.select("Favourites".underline) do |menu|
                menu.choice "Add Current", -> { favourite.save_favourite }
                menu.choice "Display", -> { favourite.display_favourites }
                menu.choice "Clear", -> { favourite.clear }
                menu.choice "Exit", -> { exit } 
            end
        end 
        
        puts 
            PROMPT.select("Search again?".underline) do |menu|
            menu.choice "Yes"
            menu.choice "Logout", -> { user.logout } 
            menu.choice "Exit", -> { exit } 
        end 
    end
end