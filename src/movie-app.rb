require_relative './lib/environment'

## ARGV's go here

# Main Menu
while true  # Loops unless our ternary operator returns 'break'
    system("clear")
    User.welcome
    login_register = PROMPT.select("", %w(Login Register Exit))

    case login_register # To do fix so there's a delay before exiting loop
    when "Login"
        system("clear")
        username = User.get_username
        password = User.get_password
        user = User.new(username, password)
        
        user.validate_login
        if user.logged_in
            break 
        else
            sleep 2
            next
        end  
            
    when "Register"
        system("clear")
        username = User.get_username
        password = User.get_password
        user = User.new(username, password)
        
        user.save_login
        if user.logged_in
            break 
        else
            sleep 2
            next
        end  
              
    when "Exit"
        exit 
    end
end

PROMPT.keypress("(Press space or enter to continue)".colorize(:green), keys: [:space, :return])

# Search Menu(s)
while user.logged_in
    system("clear")

    movie_items = MovieItems.new(user.search_movie)

    if user.search_title
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

        display_add = PROMPT.select("Favourites".underline) do |menu|
            menu.choice "Display", -> { puts "Displaying Favourites..."}
            menu.choice "Add", -> { puts "Storing current movie..." }
            menu.choice "Exit", -> { exit } 
        end

        # favourite = Favourites.new(movie.selected_movie)

        ## TODO: Setup below methods in favourites... 
        # if "display" > call display_favourites
        # if "store" > call favourite_movie
        # if "exit" > exit

        sleep 50
    else
        puts "Not a valid string"
        break
    end
end