require_relative '../config/environment.rb'
#require 'pry'
require 'rest-client'
require 'json'

require_relative "../app/models/spell.rb"
require_relative "../app/models/dnd_class.rb"
require_relative "../app/models/party.rb"
require_relative "../app/models/party_member.rb"
require_relative "../lib/api_communicator.rb"
require_relative "cli.rb"

#binding.pry

puts "HELLO WORLD"

prompt
