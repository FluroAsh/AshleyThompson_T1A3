require_relative './lib/environment'

# ARG's for user to pass
if ARGV.length > 0
    flag, *rest = ARGV
    puts "::: ARGUMENT: #{ARGV}"
    
    case flag
    when "-help"
        system("clear")
        puts "Register via the main menu if you don't have a login".colorize(:color => :black, :background => :light_white)
        puts "----------------------------------------------------"
        puts "Refer to " + "\"https://github.com/FluroAsh/AshleyThompson_T1A3\"".colorize(:blue) + " for additional information regarding set-up and use"
        puts "----------------------------------------------------"
        puts "The Ruby file can be run using the executable: " + "\"./run.sh\"".colorize(:green) + " via the terminal"
        puts "Dependencies can be installed using " + "\"./install-dependencies\"".colorize(:green) + " via the terminal"
        puts "----------------------------------------------------"
        puts "Current commands include:".colorize(:color => :black, :background => :light_white)
        puts "-info".colorize(:green) + " >> get information about the projects development"
        puts "-usernames".colorize(:green) + " >> retrieves a table of currently stored usernames"
        puts "-favourites".colorize(:green) + " >> displays a table of currently stored favourites for each user"
        exit
    when "-info"
        puts "Developed by Ashley Thompson, FX-2021-02 as a part of the CoderAcademy curriculum. Term 1, Assignment 3 (2021)"
        exit
    when "-usernames" #print usernames that exist from user-details.json
        system("clear")
        user_data = File.read("./lib/user-details.json")
        temp_json = JSON.parse(user_data)
        
        puts "Usernames".underline.colorize(:green)
        temp_json["user_data"].each_with_index do |hash, i|
            puts "#{i + 1}. \"#{temp_json["user_data"][i]["username"]}\""
        end
        exit
    when "-favourites"
        system("clear")
        user_data = File.read("./lib/favourites.json")
        temp_json = JSON.parse(user_data)

        puts "Favourites (ALL)".underline.colorize(:green)
        puts

        table = Terminal::Table.new :headings => 
        ["Name".colorize(:green), "Title".colorize(:green)] do |t|
            temp_json["favourites"].each_with_index do |h1, i|
                h1["movies"].each do |h2|
                    t << [temp_json["favourites"][i]["username"], h2["title"]]
                end
            end
        end
        puts table
        exit
    end
end

# Main Menu
while true  # Loops until user selects an exit menu.choice
    system("clear")
    User.welcome
    login_register = PROMPT.select("Menu".underline, %w(Login Register Exit))

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

    # Search Menu(s)
    while user.logged_in
        system("clear")
        movie_items = MovieItems.new
        
        puts "What movie are you looking for?".colorize(:cyan)
        print ">> ".colorize(:cyan)
        search_title = gets.chomp.strip.gsub(/\s+/, '%20') 
        
        unless search_title.size < 3 || search_title.start_with?("%20")
            movie_items.fetch_items(search_title)

            # Method returns "False" if nothing was added, 
            # Uses 'Next' to loop back into itself while user.logged_in == true
            if movie_items.add_items == "False" 
                next
            end
            
            movie_items.display_items
            movie_items.select_movie
            imdb_id = movie_items.get_imdbID
            
            movie = Movie.new(movie_items.selected_movie, imdb_id)
            movie.fetch_items
            system("clear")
            movie.display_md

            favourite = Favourites.new(user.username, movie.title, movie.year)
            favourite.parse_JSON
            
            puts ""
            PROMPT.select("Favourites".underline) do |menu|
                menu.choice "Display", -> { favourite.display_favourites }
                menu.choice "Add", -> { favourite.save_favourite }
                menu.choice "Exit", -> { exit } 
            end
        end 
        
        puts "" 
            PROMPT.select("Search again?".underline) do |menu|
            menu.choice "Yes"
            menu.choice "Exit", -> { exit } 
            menu.choice "Logout", -> { user.logout } 
        end 
    end
end


