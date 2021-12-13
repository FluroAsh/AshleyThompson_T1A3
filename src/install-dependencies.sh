#!/bin/bash
gem update --system
gem install bundler 
bundle install
bundle init
bundle add colorize
bundle add terminal-table
bundle add tty-prompt
bundle add whirly
bundle add paint
echo "***Process complete!***"