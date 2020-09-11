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

# puts "HELLO WORLD"

# # ##########delete me ######
# Party.destroy_all
# PartyMember.destroy_all


# testparty = Party.create(name: "testing")

# alivebob = testparty.add_party_member("Alivebob")
# alivebob.update(dnd_class: DndClass.find_by(name: "wizard"))
# alivebob.update(current_hp: 1)

# bob = testparty.add_party_member("Bob")
# bob.update(current_hp:  0)
# bob.update(alive: false)

# bobbity = testparty.add_party_member("Bobbity")
# bobbity.update(dnd_class: DndClass.find_by(name: "wizard"))
# harry = testparty.add_party_member("Harry")
# harry.update(dnd_class: DndClass.find_by(name: "wizard"))
# batman = testparty.add_party_member("Batman")
# batman.update(dnd_class: DndClass.find_by(name: "wizard"))
# robin = testparty.add_party_member("Robin")
# robin.update(dnd_class: DndClass.find_by(name: "wizard"))



#############delete me#####

prompt

