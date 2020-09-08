require 'rest-client'
require 'json'
require 'pry'

SPELL_URL = "/api/spells/"
ROOT_URL = "https://www.dnd5eapi.co"


def collection(url)

    spells_collection = {}

    response_hash = JSON.parse(RestClient.get(url))

   
end

def main_spider(response_hash)

    response_hash["results"].each do |spell|

        #binding.pry
        spells_collection[spell["name"].downcase] = spell["url"]

    end

    return spells_collection

end

def secondary_spider(spells_collection)




end

main_spider(collection(ROOT_URL + SPELL_URL))

puts ROOT_URL + collection["earthquake"]

#https://www.dnd5eapi.co/api/spells/earthquake