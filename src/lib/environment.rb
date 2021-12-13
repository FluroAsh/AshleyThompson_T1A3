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

# Config for Whirly
Whirly.configure spinner: "dots12"

# Creates new instance of TTY Prompt
PROMPT = TTY::Prompt.new(active_color: :magenta)
DOT = PROMPT.decorate(PROMPT.symbols[:dot] + "", :yellow)