#!/bin/sh
set -e

brew update
brew install xctool

# ensure correct version of cocoapods
bundle install