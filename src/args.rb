# ARG's for user to pass through the terminal
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
    when "-usernames"
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