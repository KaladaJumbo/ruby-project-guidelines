require_relative '../../config/environment.rb'
#require 'pry'

require_relative "spell.rb"
require_relative "dnd_class.rb"
require_relative "party.rb"

class PartyMember < ActiveRecord::Base
    belongs_to :party
    belongs_to :dnd_class

    def self.create_new(name)
        new_party_member = PartyMember.create do |p|
            p.name = name
            p.dnd_class = DndClass.all.sample
            p.level = rand(1..10)
            p.max_hp = rand(1..10) + p.level
            p.current_hp = p.max_hp
            p.alive = true
        end
    end

end