require_relative '../../config/environment.rb'
require 'pry'

require_relative "spell.rb"
require_relative "dnd_class.rb"
require_relative "party.rb"

class PartyMember < ActiveRecord::Base
    # belongs_to :party
    # belongs_to :dnd_class

end