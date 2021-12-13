require_relative './lib/environment'

class User
    attr_reader :username

    def initialize(username, password)
        @username = username
        @password = password
        @file_path = "./lib/user-details.json"
        # @search_title = search_title
        @logged_in = false
    end

    def self.welcome
        puts "
        ██     ██ ███████ ██       ██████  ██████  ███    ███ ███████ ██ 
        ██     ██ ██      ██      ██      ██    ██ ████  ████ ██      ██
        ██  █  ██ █████   ██      ██      ██    ██ ██ ████ ██ █████   ██
        ██ ███ ██ ██      ██      ██      ██    ██ ██  ██  ██ ██        
         ███ ███  ███████ ███████  ██████  ██████  ██      ██ ███████ ██\
         
         ".colorize(:green)
    end

    def self.login_register
        PROMPT.select("") do |menu|
            menu.choice "Login", -> { User.login }
            menu.choice "Register", -> { User.register}
            menu.choice "Exit", -> { exit }
        end
    end

    def self.get_username
        print "Username: ".colorize(:cyan)
        username = gets.chomp.strip.capitalize.to_s        
    end

    def self.get_password
        password = PROMPT.mask("Password:".colorize(:cyan), mask: DOT) do |q| 
            q.validate (/^(?=.*[a-zA-Z])(?=.*[0-9]).{6,}$/) # 6 char, 1 int req
            q.messages[:valid?] = "Must contain at-least 6 characters and 1 number ❌".colorize(:red)
        end
    end

    def self.login
        system('clear')
        begin
            username = User.get_username
            password = User.get_password
    
            user = User.new(username, password)

            if user.validate_login
                Whirly.start stop: ">> Login Success ✅".colorize(:green) do
                    sleep 2
                    puts "-----------------------------------------"
                    @logged_in = true
                end
            else
                raise StandardError
            end
        rescue StandardError
            Whirly.start stop: ">> \"#{username.underline}\" login failed — please try again ❌".colorize(:red) do
                sleep 2
                puts "--------------------------------------------------"
            end
            retry
        end
    end

    def self.register 
        system("clear")
        begin
            username = User.get_username
            password = User.get_password
        
            user = User.new(username, password)
            
            user.validate_login
            user.save_login
        rescue StandardError # If save_login returns error, tries the register block again
            puts ">> Username \"#{username.underline}\" already in use — please try again ❌".colorize(:red)
            puts "-----------------------------------------"
            retry
        end
    end
    
    def validate_login 
        user_data = File.read(@file_path)
        temp_json = JSON.parse(user_data)
        
        @username_check = temp_json["user_data"].find { |h1| h1["username"] == @username} ? true : false
        @password_check = temp_json["user_data"].find { |h1| h1["password"] == @password} ? true : false
        
        @username_check && @password_check
    end

    def save_login
        if @username_check == false # Check to see if there is NO match — no username in user-details
            puts "-----------------------------------------"
            puts ">> No match — creating new login ✅".colorize(:green)
            
            new_user = {username: @username, password: @password}
            user_data = File.read(@file_path)
            temp_json = JSON.parse(user_data)
            temp_json["user_data"] << new_user

            File.open(@file_path, "w") do |f|
                f.puts JSON.pretty_generate(temp_json)
            end
        else
            raise StandardError   
        end
    end

    def search_movie; end

end