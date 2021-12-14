require_relative './lib/environment'

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
        user.logged_in ? break : next 
            
    when "Register"
        system("clear")
        username = User.get_username
        password = User.get_password
        user = User.new(username, password)
        
        user.save_login
        user.logged_in ? break : next 
           
    when "Exit"
        exit 
    end
end

PROMPT.keypress("(Press space or enter to continue)".colorize(:green), keys: [:space, :return])

while user.logged_in
    system("clear")

    movie_items = MovieItems.new(user.search_movie)

    if user.search_title
        movie_items.fetch_items
        movie_items.parse_JSON
        movie_items.add_items
        
        movie_items.display_items
        movie_items.select_movie
    else
        puts "Not a valid string"
        break
    end
    


end

# Next section is user to select which movie they want to pull info for
# Will need to get IMDB id to gather specific information

