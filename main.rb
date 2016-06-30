require 'bundler'
Bundler.require

require './gmbot'
require './key'
require './models/index'

GmBot.run
