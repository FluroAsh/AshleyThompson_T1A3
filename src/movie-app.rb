require_relative './lib/environment'
system("clear")

User.welcome

login_register = PROMPT.select("", %w(Login Register Exit))

case login_register
when "Login"
    system("clear")
        begin
            username = User.get_username
            password = User.get_password
        
            user = User.new(username, password)
            user.validate_login
            
            if user.logged_in
                Whirly.start stop: ">> Login Success ✅".colorize(:green) do
                    sleep 2
                    puts "-----------------------------------------"
                end
            else
                raise StandardError 
            end
        rescue StandardError
            puts ">> \"#{username.underline}\" login failed — please try again ❌".colorize(:red)
            puts "-----------------------------------------"
            retry
        end
        
when "Register"
    system("clear")
    begin
        username = User.get_username
        password = User.get_password
    
        user = User.new(username, password)
        user.validate_login
        user.save_login
    rescue StandardError
        puts ">> Username \"#{username.underline}\" already in use — please try again ❌".colorize(:red)
        puts "-----------------------------------------"
        retry
    end

when "Exit"
    exit
end

PROMPT.keypress("(Press space or enter to continue)".colorize(:green), keys: [:space, :return])