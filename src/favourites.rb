require_relative './lib/environment'

class Favourites
    attr_reader :favourites_arr

    def initialize(username, title, year)
        @username = username
        @file_path = "./lib/favourites.json"
        @title = title
        @year = year
        @favourites_arr = []
    end

    def parse_JSON
        @favourites_data = File.read(@file_path)
        @temp_json = JSON.parse(@favourites_data)
    end

    def save_favourite
        @username_check = @temp_json["favourites"].find { |h1| h1["username"] == @username} ? true : false 

        if @username_check
            @temp_json["favourites"].each_with_index do |hash, i|
                if hash["username"] == @username
                    new_favourite = {title: @title, year: @year}
                    @temp_json["favourites"][i]["movies"] << new_favourite

                    File.open(@file_path, "w") do |f|
                    f.puts JSON.pretty_generate(@temp_json)
                    end
                end
            end
            puts ">> Added movie: ".colorize(:green) + "\"#{@title}\"".colorize(:cyan) + " to user: \"#{@username}\"! ✅".colorize(:green)
        else
            # Creates new user with title, year
            puts ">> Did not find \"#{@username}\" in the favourites database! ❌".colorize(:red)
            puts ">> Creating a new favourites entry for \"#{@username}\"... ✅".colorize(:green)

            puts "..."
            new_favourite = {username: @username, movies: [{title: @title, year: @year}]}
            @temp_json["favourites"] << new_favourite

            File.open(@file_path, "w") do |f|
            f.puts JSON.pretty_generate(@temp_json)
            end
        end
    end

    def display_favourites
        @username_check = @temp_json["favourites"].find { |h1| h1["username"] == @username} ? true : false # Detects if user exists in the favourites database
       
        if @username_check 
            puts "These are your favourites! 🙌".colorize(:cyan)

            @temp_json["favourites"].each_with_index do |h1, i|
                if h1["username"] == @username
                    h1["movies"].each do |h2|
                        @favourites_arr << [h2["title"], h2["year"]]
                    end
                end
            end
            
            table = Terminal::Table.new :headings => 
            ["Title".colorize(:magenta), "Year".colorize(:magenta)] do |t|
                @favourites_arr.each_with_index do |e, i|
                    t << @favourites_arr[i]
                end
            end
            puts table
        else 
            puts ">> No usernames found! ❌ — Try adding a favourite movie first! 😄".colorize(:red)
        end
    end

    def clear(*option)
        if option == "Skip" # Optional parameter to bypass PROMPT.select
            PROMPT.select("This will remove all favourites from: " + "\"#{@username}\" ".colorize(:cyan) + "Are you sure?".underline) do |menu|
                menu.choice "Yes"
                menu.choice "No", -> { exit }
            end
        end
        
        puts ">> Cleared favourites for \"#{@username}\" ✅".colorize(:green)

        @temp_json["favourites"].each_with_index do |h1, i|
            if h1["username"] == @username
                @temp_json["favourites"][i].clear
                @temp_json["favourites"].delete({}) # Deletes empty hash remainder
            end
        end
        
        File.open(@file_path, "w") do |f|
            f.puts JSON.pretty_generate(@temp_json)
        end
    end
end