require_relative '../../config/environment.rb'
#require 'pry'

require_relative "dnd_class.rb"
require_relative "party.rb"
require_relative "party_member.rb"

class Spell < ActiveRecord::Base
    belongs_to :dnd_class
end