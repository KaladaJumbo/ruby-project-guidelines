require_relative '../../config/environment.rb'
require 'pry'

require_relative "spell.rb"
require_relative "dnd_class.rb"
require_relative "party_member.rb"

class Party < ActiveRecord::Base
    # has_many :party_members
    # has_many :dnd_classes, through: :party_members
end