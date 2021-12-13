require_relative './lib/environment'
require_relative './favourites'
require_relative './movie'
require_relative './movie-items'
require_relative './user'
system("clear")


PROMPT = TTY::Prompt.new

login_register = PROMPT.select("", %w(Login Register Exit))
# 
case login_register
when "Login"
    puts "Please enter a username: "
    # Create new user
    # Validate username + password
    # else try again
    
    user = User.new("Ashley", "12345")


when "Register"
    puts ">> Register test ✅"
when "Exit"
    exit
end