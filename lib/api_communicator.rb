require 'rest-client'
require 'json'
#require_relative '../config/environment.rb'
require 'pry'

SPELL_URL = "/api/spells/"
ROOT_URL = "https://www.dnd5eapi.co"


def collection(url)

    response_hash = JSON.parse(RestClient.get(url))
   
end

def main_spider(response_hash)

    spells_collection = {}

    response_hash["results"].each do |spell|

        #binding.pry
        spells_collection[spell["name"].downcase] = spell["url"]

    end

    return spells_collection

end

def secondary_spider(spells_collection)
    binding.pry
    test = spells_collection.map { |spell, url|
        collection(ROOT_URL + url)
    }
    binding.pry
end

def spells_parser(array_of_spell_hashes)
    array_of_spell_hashes.each { |spell_hash|
        binding.pry
        new_spell = Spell.new()
        new_spell.name = spell_hash["name"]
    }
end

spells_urls = main_spider(collection(ROOT_URL + SPELL_URL))
spells_parser(secondary_spider(spells_urls))

#puts ROOT_URL + spells_urls["earthquake"]
#https://www.dnd5eapi.co/api/spells/earthquake