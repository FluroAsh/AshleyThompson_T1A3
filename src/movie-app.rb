require_relative './lib/environment'

while true  # Loops menu until 'exit' condition is found
# TODO: Include validation for exiting 'login' or 'register' 
    system("clear")
    User.welcome
    login_register = PROMPT.select("", %w(Login Register Exit))

    case login_register
    when "Login"
        system("clear")
        username = User.get_username
        password = User.get_password
        user = User.new(username, password)
        user.validate_login
        break
            
    when "Register"
        system("clear")
        username = User.get_username
        password = User.get_password
        user = User.new(username, password)
        user.save_login
        break
           
    when "Exit"
        exit 
    end
end

while user.logged_in
    PROMPT.keypress("(Press space or enter to continue)".colorize(:green), keys: [:space, :return])

    system("clear")
    
    movie_items = MovieItems.new(user.search_movie)

    if user.search_title
        movie_items.fetch_items
        movie_items.parse_JSON
        movie_items.add_items
        
        movie_items.display_items
    else
        puts "Not a valid string"
    end

    sleep 30
end

# Next section is user to select which movie they want to pull info for
# Will need to get IMDB id to gather specific information

