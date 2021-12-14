require_relative './lib/environment'

while true # Loops menu until 'exit' condition is found
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

    # user.search_movie
    # Get input from user, return and build upon movie-items/movie class
end

