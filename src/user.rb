require_relative './lib/environment'

class User
    attr_reader :username
    
    def initialize(username, password)
        @username = username
        @password = password
        @file_path = "./lib/user-details.json"
        # @search_title = search_title
        # @logged_in = logged_in
    end

    def welcome
        # ASCII Art Welcome Message Will Go Here!!!
        ## Not a priority currently
        puts "Welcome!"
    end

    def get_username
        @username
    end

    def validate_login 
        user_data = File.read(@file_path)
        temp_json = JSON.parse(user_data)
        
        result = temp_json["user_data"].find { |h1| h1["username"] if h1["username"] == @username} ?  true : false
        return result
    end

    def save_login
        if validate_login() == false
            puts "No match, creating new login..."
            new_user = {username: @username, password: @password}
        
            user_data = File.read(@file_path)
            temp_json = JSON.parse(user_data)
            temp_json["user_data"] << new_user

            File.open(@file_path, "w") do |f|
                f.puts JSON.pretty_generate(temp_json)
            end
        else
            puts "Username already in use, please try again"
        end
    end

    def search_movie; end

end




