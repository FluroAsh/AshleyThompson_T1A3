require_relative './lib/environment'

class User
    attr_reader :username, :logged_in

    def initialize(username, password)
        @username = username
        @password = password
        @file_path = "./lib/user-details.json"
        # @search_title = search_title
        @logged_in = false
    end

    def self.welcome
        puts "
            iWWMMMMBt+++VBMBRBVBXXXBBBMMMMMMBMMMM
            iWMRRXRRI+IVBXXBBBBBBRBXXRBMBMRXXXBBBMMMM
        VWMRYiYVXtIRBBBBMMMMMMMMMMMMWWMMMBXYtIYXMBB
        =RWWWBI  =BRXXRRRBBMMMMMMMWMMMMMMMMBBBRVVXRXRV
        tWWMWWWY ;WBXVXXRRBBMMMMMMWWWMMWWWWMMMBRRXXXVVI
    +WWWMMWWX;VBVIVVXRRRMMMWWWWWWWMMWWWWMMMBRRBRRRVi
    MWWWWBRMBYXVVXI+;;+iIXBWWWWWWWWWWWWWWMMBBBRBBBBMI
    XWWWWMVRXVt;t+=IXBRRYi=iVMWWWWWWMXVYIYVYVBBBBBBRBMBI
    ,MWMWBYXXRBR=.=tYVBMMWMV=+RMWWWWBXVIVRRRRViIBBRBXYMWWV
    MWRRItRBMMMM::+,+ttIVVMM;iBMWWMRRMMWWMBRRRYiVVtVVRBMY
    MWXtX=tMMMMMIt,.:=tYBMRBBIBWWMMMVIItXBMXVVI+tIiI:YRXMB
    WMBIiR+YtBBMXRBMMMMMMMBRYRMWMMMMWWXti,.;tItIIYYiRRBBMMV
    ,MWMMtIRR=,+XBBMMMMMMMMWR:;RWWBRMMWWWMBRXYXBBXYYV+VMWMBMMM
    VWMMi::BW,  IIRMMMMWWWWX+..,I+:iMMWWWWWWMMMBBRXVXYRMMWMBMMX
    +WMMY::,BX   :RMBMMMWWMMRYVVXMWBXVMWWWWWWWMMBRXXXXYIRMBMMBBMR
    =WMBBi:tt    tBBRBBMMMMRYtitYYVXMWWWWWMWWMMBXXVYXVi:VMMMMMMWV
    RWRV+,;,,   XBRRRBBBt,..:+t=+:..+RWWWWWMBBXVVVXXIiI:IVMMBMMMW
    IMRBRRBMB=  YXRRRBBBB,..+YBBBBV...=MWWMBBRRVVXXBYXRRBXBMMBMMMB
    tMYitIXMi    iYXXRXRBRt;.:itt=:=iXMWWWMBBRRVXXRRVRMWWMMMMMMBBB
    :MR:.,:Ii      YVVXRBBBMMRRRBMWMMMMMMMMBBRXXXYY+VMXMWMBMMBBVVRI
    :RY+            iVRBBBBMMMWWWMMMMMMMBBBBRRXVt.iXYRYXMBBBYItVVt
    =XVY,            ;tVRBBMMMWWWMMMMBMBBBBXVYt  iXBMWWMRVXYXMMY
    RX:,              ,,;+tIIVXRBBRXVVIIi=,.=  iYYt+;,;iYRMMXt
    ".colorize(:green)
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

        begin 
            if @logged_in
                Whirly.start stop: ">> Login Success ✅".colorize(:green) do
                    sleep 2
                    puts "-----------------------------------------"
                end
            else
                raise StandardError 
            end
        rescue StandardError
            Whirly.start stop: ">> \"#{username.underline}\" login failed — please try again ❌".colorize(:red) do
                sleep 2
                puts "-----------------------------------------"
            end
        end
    end

    def save_login
        user_data = File.read(@file_path)
        temp_json = JSON.parse(user_data)

        begin
            @username_check = temp_json["user_data"].find { |h1| h1["username"] == @username} ? true : false

            if @username_check == false
                Whirly.start stop: ">> No match, creating new login ✅".colorize(:green) do
                sleep 2
                puts "-----------------------------------------"
                end
                
                new_user = {username: @username, password: @password}
                temp_json["user_data"] << new_user

                File.open(@file_path, "w") do |f|
                    f.puts JSON.pretty_generate(temp_json)
                end
            else
                raise StandardError   
            end
        rescue StandardError
            Whirly.start stop: ">> Username \"#{username.underline}\" already in use — please try again ❌".colorize(:red) do
            sleep 2
            puts "-----------------------------------------"
            end
        end
    end

    def search_movie
        # Get title from user
        # Initialize into movie-items

        # puts "What movie are you looking for?"
        # print ">> "
        # movie = gets.chomp.gsub(/\s+/, '%20')
    end
end