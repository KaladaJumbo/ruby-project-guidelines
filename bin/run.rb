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

###########delete me ######
Party.destroy_all

testparty = Party.create(name: "testing")

alivebob = testparty.add_party_member("alivebob")
alivebob.update(dnd_class: DndClass.find_by(name: "cleric"))
alivebob.update(current_hp: 1)

bob = testparty.add_party_member("bob")
bob.update(current_hp:  0)
bob.update(alive: false)

bobbity = testparty.add_party_member("bobbity")
harry = testparty.add_party_member("harry")
batman = testparty.add_party_member("batman")
robin = testparty.add_party_member("robin")



#############delete me#####

prompt

