require 'rest-client'
require 'json'
require_relative '../config/environment.rb'
require 'pry'
require_relative "../app/models/spell.rb"
require_relative "../app/models/dnd_class.rb"
require_relative "../app/models/party.rb"
require_relative "../app/models/party_member.rb"



SPELL_URL = "/api/spells/"
ROOT_URL = "https://www.dnd5eapi.co"


def collection(url)

    response_hash = JSON.parse(RestClient.get(url))
   
end

def main_spider(response_hash)

    spells_collection = {}

    response_hash["results"].each do |spell|

        
        spells_collection[spell["name"].downcase] = spell["url"]

    end

    return spells_collection

end

def secondary_spider(spells_collection)
    
    test = spells_collection.map { |spell, url|
        collection(ROOT_URL + url)
    }
   
end

def spells_parser(array_of_spell_hashes)

    array_of_spell_hashes.each { |spell_hash|
        
        Spell.create do |t|

            t.name = spell_hash["name"]
            t.description = spell_hash["desc"][0]
            t.level = spell_hash["level"]

            if spell_hash["damage"]

                if spell_hash["damage"]["damage_at_slot_level"]

                    damage = spell_hash["damage"]["damage_at_slot_level"].first.second.split("d")

                elsif spell_hash["damage"]["damage_at_character_level"]  

                    damage = spell_hash["damage"]["damage_at_character_level"].first.second.split("d")

                else

                    damage = [0,0]

                end

                t.min_damage = damage[0].to_i
                t.max_damage = damage[0].to_i * damage[1].to_i
                if t.max_damage < t.min_damage
                    t.max_damage = t.min_damage
                end

                if spell_hash["damage"]["damage_type"]

                    t.damage_type  = spell_hash["damage"]["damage_type"]["name"] 

                end
                
            end

            if spell_hash["classes"].any? {|c| c["name"] == "Wizard"} 

                wiz = DndClass.find_by(name: "wizard")
                t.dnd_class_id = wiz.id

            elsif spell_hash["classes"].any? {|c| c["name"] == "Cleric"}

                healzz = DndClass.find_by(name: "cleric")
                t.dnd_class_id = healzz.id

            end
            
        end
        
    }
     
end

def load_api
    #must destroy contents in Spell database before it can be run 
    if Spell.all.count == 0
        puts ""
        puts "LOADING ..."
        puts ""
        spells_urls = main_spider(collection(ROOT_URL + SPELL_URL))
        new_shit = spells_parser(secondary_spider(spells_urls))

    else
        puts "-- ERROR -- database still populated"
        puts "run destory_all on SPELL database"
    end

end

#finished the spell table 
#and have to start on relations and fleshing out other tables 