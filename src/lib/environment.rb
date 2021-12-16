# Gem List (min 5 for HD)
require 'colorize'
require 'terminal-table'
require 'tty-prompt'
require 'whirly'
require 'paint'

# Classes
require_relative '../user'
require_relative '../favourites'
require_relative '../movie'
require_relative '../movie-items'

# Default gems
require 'json'
require 'uri'
require 'net/http'
require 'openssl'

# Config for Whirly
Whirly.configure spinner: "shark", interval: 60

# Config for Terminal Table
# Terminal::Table::Style.defaults = {:width => 120}

# Prompt instance & Dot constant
PROMPT = TTY::Prompt.new(active_color: :magenta)
DOT = PROMPT.decorate(PROMPT.symbols[:dot] + "", :yellow)