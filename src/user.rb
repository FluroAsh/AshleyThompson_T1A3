require_relative './lib/environment'

class User
    attr_reader :username, :logged_in

    
    def initialize(username, password)
        @username = username
        @password = password
        @file_path = "./lib/user-details.json"
        # @search_title = search_title
        @logged_in = nil
    end

    def self.welcome
        puts "Welcome".colorize(:green)
    end

    def self.get_username
        print "Username: ".colorize(:cyan)
        username = gets.chomp.strip.capitalize.to_s        
    end

    def self.get_password
        password = PROMPT.mask("Password:".colorize(:cyan), mask: DOT) do |q| 
            q.validate (/^(?=.*[a-zA-Z])(?=.*[0-9]).{6,}$/) # Requires 6 char, 1 number
            q.messages[:valid?] =  "Must contain at-least 6 characters and 1 number".colorize(:red)
        end
    end

    def validate_login 
        user_data = File.read(@file_path)
        temp_json = JSON.parse(user_data)
        
        @username_check = temp_json["user_data"].find { |h1| h1["username"] == @username} ? true : false
        @password_check = temp_json["user_data"].find { |h1| h1["password"] == @password} ? true : false
        
        
        @logged_in = @username_check && @password_check
    end

    def save_login
        if @username_check == false
            puts ">> No match, creating new login ✅".colorize(:green)
            puts "-----------------------------------------"
            
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