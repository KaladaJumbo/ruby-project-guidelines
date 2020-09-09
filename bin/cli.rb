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
    puts "Welcome to <insert_pub_name>, #{party.name.titlecase}!\n"
    game(party)
end

def game(party)
    #system "clear" || system "cls"
    puts "\nMenu:"
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
    when "4"
        #fight troll
    when "5"
        #view party
        view_party(party)
    when "6"
        #exit
    else
        clear_screen
        puts "Invalid response, try again.\n"
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
            puts "Your party can have up to #{space} more members.\n"
        else
            puts "Your party is now full.\n"
        end
    else
        puts "\nYour party is full.\n"
    end
    game(party)
end

def view_party(party)
    clear_screen
    party.party_members.each { |member|
        puts "#{member.name}\t\tLevel #{member.level} #{member.dnd_class.name.capitalize}\t\tCurrent HP: #{member.current_hp}"
    }
    puts "\n"
end

def heal_party(party)
    if party_has_cleric?
        party.party_members.each { |member|
            member.current_hp = member.max_hp
        }
        message = Spell.find_by(name: "Mass Cure Wounds").description
        puts message
    else
        puts "Your party has no Cleric!"
    end
    game(party)
end

def party_has_cleric?
    Party.party_members.any? { |member|
        member.dnd_class == DndClass.find_by(name: "cleric")
    }
end

def clear_screen
    if Gem.win_platform?
        system 'cls'
    else
        system 'clear'
    end    
end

