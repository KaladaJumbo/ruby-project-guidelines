require_relative '../../config/environment.rb'
#require 'pry'

require_relative "spell.rb"
require_relative "party.rb"
require_relative "party_member.rb"

class DndClass < ActiveRecord::Base
    has_many :party_members
    has_many :spells
    has_many :parties, through: :party_members
end