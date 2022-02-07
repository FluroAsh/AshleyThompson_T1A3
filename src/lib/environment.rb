# Gem List (min 5 for HD)
require 'colorize'
require 'terminal-table'
require 'tty-prompt'
require 'whirly'
require 'paint'

# Classes
require_relative '../args'
require_relative '../user'
require_relative '../favourites'
require_relative '../movie'
require_relative '../movie-items'
require_relative '../../.api_key.rb'

# Default gems
require 'json'
require 'uri'
require 'net/http'
require 'openssl'

# Config for Whirly
Whirly.configure spinner: "shark", interval: 60

# Prompt instance & Dot constant
PROMPT = TTY::Prompt.new(active_color: :magenta)
DOT = PROMPT.decorate(PROMPT.symbols[:dot] + "", :yellow)