require_relative './lib/environment'
system("clear")

# prompt.keypress("Press space or enter to continue", keys: [:space, :return])

User.welcome

dot = PROMPT.decorate(PROMPT.symbols[:dot] + "", :yellow)
login_register = PROMPT.select("", %w(Login Register Exit))

case login_register
when "Login"
    system("clear")

        begin
            username = User.get_username
            # password = User.get_password
            password = PROMPT.mask("Password:".colorize(:cyan), mask: dot) do |q| 
                # At-least 6 characters followed by a number; https://stackoverflow.com/questions/11992544/validating-password-using-regex
                q.validate (/^(?=.*[a-zA-Z])(?=.*[0-9]).{6,}$/)
                q.messages[:valid?] = "Must contain at-least 6 characters and 1 number".colorize(:red)
            end
        
            user = User.new(username, password)
            
            if user.validate_login
                Whirly.start stop: "*** Login Success ✅ ***".underline.colorize(:green) do
                    sleep 3
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
        password = PROMPT.mask("Password please! ".colorize(:cyan), mask: dot) do |q| 
            # At-least 6 characters followed by a number; https://stackoverflow.com/questions/11992544/validating-password-using-regex
            q.validate (/^(?=.*[a-zA-Z])(?=.*[0-9]).{6,}$/)
            q.messages[:valid?] =  "Must contain at-least 6 characters and 1 number".colorize(:red)
        end
    
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

puts "Next block will go here"
