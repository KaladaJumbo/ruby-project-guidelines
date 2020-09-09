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

def view_party(party)
    clear_screen
    #puts "#{party.name.titlecase}:"

    party.party_members.each { |member|
        dead = ""
        if !member.alive
            dead = "\t*DEAD*"
        end
        puts "#{tabation(member.name)}Level #{member.level} #{member.dnd_class.name.capitalize}\t\t\tHP: #{member.current_hp}/#{member.max_hp} #{dead}"
    }
    print "\n\nPress #{localization} to return to menu. "
    gets.chomp
    clear_screen
    game(party)
end


def heal_party(party)
    if party_has_cleric?(party)
        party.party_members.each { |member|
            if member.alive
                member.current_hp = member.max_hp
            else
                puts "hey .. ummm #{member.name} is dead... should we bury them??"
            end
        }
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
    response = gets.chomp
    dead_memeber = party.party_members.find_by(name: response)


    if !dead_memeber.alive
        dead_memeber.destroy()
        puts "sad song ... \n\n"
    else
        clear_screen
        puts "this person is not dead yet you sick ..... yeah\n\n"

    end

    game(party)

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

