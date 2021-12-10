#!/bin/bash
gem install bundler 
bundle install
bundle init
bundle add rspec
bundle add colorize
bundle add terminal-table
bundle add tty-prompt
echo "***Process completed!***"