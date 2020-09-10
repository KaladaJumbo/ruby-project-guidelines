def prompt
    clear_screen
    puts "In a world... somethingsomethingsomething...
    Defeat the Troll.\n\n"
    create_party
end

def create_party
    puts "1 - Load Game"
    puts "2 - New Game\n\n"
    response = gets.chomp
    if response == "1"
        load_game
    elsif response == "2"
        new_game
    else
        clear_screen
        puts "Invalid response, try again.\n\n"
        create_party
    end
end

def new_game
    print "\nName your party: "
    response = gets.chomp
    party = Party.create(name: response)
    start_game(party)
end

def load_game
    clear_screen
    puts "\nWhat is your party's name?"
    Party.all.each { |party|
        puts party.name
    }
    response = gets.chomp
    party = Party.find_by(name: response)
    if party == nil
        puts "Party not found"
        create_party
    else
        start_game(party)
    end
end

def start_game(party)
    clear_screen
    puts "Welcome to <insert_pub_name>, #{party.name.titlecase}!\n\n"
    game(party)
end

def game(party)
    #system "clear" || system "cls"
    puts "Menu:"
    puts "1 - Add Party Member"
    puts "2 - Heal Party"
    puts "3 - Bury Dead Member"
    puts "4 - Fight Monsters"
    puts "5 - View Party Members"
    puts "6 - Exit\n\n"
    response = gets.chomp

    clear_screen

    case response
    when "1"
        #add party member
        new_party_member(party)
    when "2"
        #heal party
        heal_party(party)
    when "3"
        #bury dead people
        bury_dead(party)
    when "4"
        #fight troll
        troll_hp = 100

        puts "you walk towards a field and out of a pokeball pops out a troll!!!"
        puts "you and your party have no pokeballs so your" 
        puts "only option is to fight"

        fight_troll(party, troll_hp)
    when "5"
        #view party
        view_party(party)
    when "6"
        #exit
    else
        clear_screen
        puts "Invalid response, try again.\n\n"
        game(party)
    end
            
end

def new_party_member(party)
    if party.party_members.count < 6
        clear_screen
        puts "What is your new party member's name?\n\n"
        response = gets.chomp.capitalize
        guy = party.add_party_member(response)
        space = 6 - party.party_members.count
        clear_screen # clears return value
        puts "Congratulations! #{guy.name} has joined the party!"
        if space != 0
            puts "Your party can have up to #{space} more members.\n\n"
        else
            puts "Your party is now full.\n\n"
        end
    else
        clear_screen
        puts "\nYour party is full.\n\n"
    end
    game(party)
end

def print_party(party)

    party.party_members.each { |member|
        dead = ""
        if !member.alive
            dead = "\t*DEAD*"
        end
        puts "#{tabation(member.name)}Level #{member.level} #{member.dnd_class.name.capitalize}\t\t\tHP: #{member.current_hp}/#{member.max_hp} #{dead}"
    }

end

def view_party(party)
    print_party(party)
    clear_screen
    #puts "#{party.name.titlecase}:"
    print_party(party)

    game_wait
    game(party)
end


def heal_party(party)
    if party_has_cleric?(party)
        party.party_members.each { |member|
            if member.alive
                member.update(current_hp: member.max_hp) 
            else
                puts "hey .. ummm #{member.name} is dead... should we bury them??"
            end
        }
        party = updated_party(party)
        clear_screen
        message = Spell.find_by(name: "Mass Cure Wounds").description
        message.split(".").each { |line|
        puts line + "."
        }
        puts "\n"
    else
        puts "\nYour party has no Cleric!\n\n"
    end
    game(party)
end

def party_has_cleric?(party)
    party.party_members.any? { |member|
        member.dnd_class == DndClass.find_by(name: "cleric") && member.alive
    }
end

def bury_dead(party)
    clear_screen
    puts "Sorry for your loss... get good scrub\n\n"
    puts "please enter name of dead party member you wish to bury:\n"

    print_party(party)

    puts ""
    response = gets.chomp
    dead_member = party.party_members.find_by(name: response)


    if dead_member

        if !dead_member.alive && dead_member.party == party
            dead_member.destroy
            party = updated_party(party) 
            clear_screen
            puts "sad song ... \n\n"
        elsif dead_member
            clear_screen
            puts "this person is not dead yet you sick ..... yeah\n\n"

        end

    else

        clear_screen
        puts "invalid input.\n\n"

    end

    game(party)

end

def fight_troll(party, troll_hp)
    
    clear_screen

    if troll_hp > 0
        
        puts "Troll HP:\t#{troll_hp}/100\n\n"
        puts "Menu:"
        puts "1 - Attack"
        puts "2 - Run!!! you coward"
        puts "5 - View Party Members"

        response = gets.chomp

        case response
        when "1"
            #attack... random party member cast a random spell within limits
            
            troll_hp = attack(party, troll_hp)

            party = troll_attack(party, troll_hp)

            if party.party_members.any?{|member| member.alive == true}
            
                fight_troll(party, troll_hp)

            else
                wiped_party(party)
            end

    when "2"
            clear_screen
            puts "\nyou ran ... your cow watches you in shame\n"
    when "5"
        clear_screen
        print_party(party)
        game_wait
        fight_troll(party, troll_hp)
    else
        fight_troll(party, troll_hp)
    end
        
        party = updated_party(party)
        game(party)
       
    else
        clear_screen
        puts "congrats you win ... now like and subscribe and smash that bell!!"
        credits(party)
    end

end

def attack(party, troll_hp)

    living_randos = party.party_members.select { |member| member.alive}

    rando = living_randos.sample

    castable = Spell.all.select do |spell|

        if spell.level
            rando.dnd_class == spell.dnd_class && spell.level <= rando.level && spell.min_damage
        end

    end
    

    troll_hp -= cast_spell(castable.sample, rando)

end

def wiped_party(party)

    print_party(party)
    clear_screen
    puts "everyone has died ... "
    puts ""
    puts "the troll knew you were a scrub from the moment he laid eyes on you.... "
    puts ".... look at the fools as their body lay on the floor...."
    puts ".... LOOK AT THEM!!!!!!"
    puts ""

    print_party(party) #losscredits??
    game_wait
    exit

end


def troll_attack(party, troll_hp) #returns party

    
    if troll_hp < 1

        clear_screen
        puts "\n\n\n"
        puts "you got me ..... ugh ... tell my trolls"
        puts "I... I... ugh... x_x .."
        puts ""
        puts "                     #"
        puts "                    ###"
        puts "                   #####"
        puts "                  ########"
        puts "                 ##########"
        puts "                #############"
        puts "              #################"
        puts "             ###################"
        puts "           #######################"
        puts "         ############################"
        puts "       ################################"
        puts "     ####################################"
        puts "   #######______#############______#######"
        puts "  #########|################################"
        puts " ##########|####################|############"
        puts " ##########|####################|############"
        puts " ############################################"
        puts " ############################################"
        puts " ###########____________________#############"
        puts "  #########|###################||###########"
        puts "   ########|###################||##########"
        puts "    ###########################||#########"
        puts "       ########################||######"
        puts "                               ||"

        game_wait
        return party

    elsif troll_hp = 1

         party = rando_takes_damage(party)

        clear_screen
        puts "ha!... you will never kill me with those puny attacks...."
        puts "only certain elements can kill me ... "
        puts "if you dont have Acid, Poison, Fire, or Radiant"
        puts "its best if you just lie down and let me touch you...consentually.. ofc"
        puts ""
        puts "MUAHAHAHAHAHAHAHA *coughs* UAHAHAHAHAHAHAHAHA"
        puts 
        puts "ROAR!"
        puts "get ready got pay the troll toll"

        return party 

    else

        clear_screen

        rando_quote = ["nice one", "ugh", "my turn", "weak..", "take this", "...", "thats all you got?", "pikachu .. quick attack"].sample

        puts "\t\t#{rando_quote}"

        party = rando_takes_damage(party)

    end
    

end


def cast_spell(rando_spell, rando)

    clear_screen
    puts rando_spell.description
    damage = rand(rando_spell.min_damage..rando_spell.max_damage)
    damage_type = rando_spell.damage_type
    if damage_type == nil
        damage_type = ""
    end 
    puts "\n#{rando.name.capitalize}'s #{rando_spell.name} hit the troll for #{damage} #{damage_type.downcase} damage"
    game_wait
    return damage

end



def credits(party)

    print_party(party)
    clear_screen
    print_party(party)
    clear_screen
    puts "you find epic loot from the trools corps!!"
    puts "it is ....... trolls blood!!!! and epic loin cloth!!!"
    puts "Thank you for playing"
    puts ""
    puts "these are the people who made this possible:"
    print_party(party)
    gets
    exit

end

## everytime we hit troll he hits a random party member
## impliment heal in combat 
## bonus -- trolls death depends on damage type 


######################### start helper methods ##########################


def rando_takes_damage(party) #returns false if party member survies and false otherwise

    rando = party.party_members.where("alive == true").sample
    rando_damage_taken = rand(1..20)
    c_hp = rando.current_hp - rando_damage_taken
    if c_hp < 0 
        c_hp = 0
    end
    rando.update(current_hp: c_hp)
    party = updated_party(party)
    clear_screen
    puts ""
    puts "#{rando.name.capitalize} has taken #{rando_damage_taken} Reddit damage..."
    puts ""

    if rando.current_hp < 1

        puts ""
        puts "#{rando.name.capitalize} has died ......"
        puts "they were trash anyway... one less mouth to feed"
        game_wait
        rando.update(alive: false)
        party = updated_party(party)

        clear_screen
        return party

    end


    game_wait
    party = updated_party(party)

    clear_screen
    return party

end


def game_wait

    print "\n\nPress #{localization} to continue..."
    gets
    clear_screen

end

def updated_party(party)

    up_party = Party.find(party.id)

    return up_party

end

def clear_screen
    if Gem.win_platform?
        system 'cls'
    else
        system 'clear'
    end    
end

def localization
    if Gem.win_platform?
        "'enter'"
    else
        "'return'"
    end  
end

def tabation(name)

    if name.size < 8 
        return "#{name}\t\t\t"
    else
        return "#{name}\t\t"
    end

end

