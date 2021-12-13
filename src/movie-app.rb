require_relative './lib/environment'

while true
    system("clear")
    User.welcome
    User.login_register
    sleep 2

end

# create instance of user...
# call my methods so they can be called indepedently... 



PROMPT.keypress("(Press space or enter to continue)".colorize(:green), keys: [:space, :return])
