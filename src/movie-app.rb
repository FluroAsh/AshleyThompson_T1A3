require_relative './lib/environment'
# Interface will go here, faciliated by TTY::PROMPT

system("clear")

PROMPT = TTY::Prompt.new
puts "||===========================================||"
login_register = PROMPT.select("", %w(Login Register Exit))

case login_register
when "Login"
    puts ">> Logged in"
    # Create new user
    # Validate username + password
    # else try again
when "Register"
    puts ">> Registered"
when "Exit"
    exit
end
