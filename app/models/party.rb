require_relative '../../config/environment.rb'
#require 'pry'

require_relative "spell.rb"
require_relative "dnd_class.rb"
require_relative "party_member.rb"

class Party < ActiveRecord::Base
    has_many :party_members
    has_many :dnd_classes, through: :party_members

    def add_party_member(name)
        new_party_member = PartyMember.create_new(name)
        self.party_members.push(new_party_member)
        new_party_member
    end
end