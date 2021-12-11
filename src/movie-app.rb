require_relative './lib/environment'
# Interface will go here, faciliated by TTY::PROMPT

system("clear")

PROMPT = TTY::Prompt.new
puts "||===========================================||"
login_register = PROMPT.select("", %w(Login Register Exit))

case login_register
when "login"
    puts "logged in"
when "register"
    puts "registered"
when "exit"
    exit
end
