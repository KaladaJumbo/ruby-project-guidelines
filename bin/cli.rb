require 'rainbow'

def title_screen

title = <<END
                            ...----....
                         ..-:"''         ''"-..
                      .-'                      '-.
                    .'              .     .       '.
                  .'   .          .    .      .    .''.
                .'  .    .       .   .   .     .   . ..:.
              .' .   . .  .       .   .   ..  .   . ....::.
             ..   .   .      .  .    .     .  ..  . ....:IA.
            .:  .   .    .    .  .  .    .. .  .. .. ....:IA.
           .: .   .   ..   .    .     . . .. . ... ....:.:VHA.
           '..  .  .. .   .       .  . .. . .. . .....:.::IHHB.
          .:. .  . .  . .   .  .  . . . ...:.:... .......:HIHMM.
         .:.... .   . ."::"'.. .   .  . .:.:.:II;,. .. ..:IHIMMA
         ':.:..  ..::IHHHHHI::. . .  ...:.::::.,,,. . ....VIMMHM
        .:::I. .AHHHHHHHHHHAI::. .:...,:IIHHHHHHMMMHHL:. . VMMMM
       .:.:V.:IVHHHHHHHMHMHHH::..:" .:HIHHHHHHHHHHHHHMHHA. .VMMM.
       :..V.:IVHHHHHMMHHHHHHHB... . .:VPHHMHHHMMHHHHHHHHHAI.:VMMI
       ::V..:VIHHHHHHMMMHHHHHH. .   .I":IIMHHMMHHHHHHHHHHHAPI:WMM
       ::". .:.HHHHHHHHMMHHHHHI.  . .:..I:MHMMHHHHHHHHHMHV:':H:WM
       :: . :.::IIHHHHHHMMHHHHV  .ABA.:.:IMHMHMMMHMHHHHV:'. .IHWW
       '.  ..:..:.:IHHHHHMMHV" .AVMHMA.:.'VHMMMMHHHHHV:' .  :IHWV
        :.  .:...:".:.:TPP"   .AVMMHMMA.:. "VMMHHHP.:... .. :IVAI
       .:.   '... .:"'   .   ..HMMMHMMMA::. ."VHHI:::....  .:IHW'
       ...  .  . ..:IIPPIH: ..HMMMI.MMMV:I:.  .:ILLH:.. ...:I:IM
     : .   .'"' .:.V". .. .  :HMMM:IMMMI::I. ..:HHIIPPHI::'.P:HM.
     :.  .  .  .. ..:.. .    :AMMM IMMMM..:...:IV":T::I::.".:IHIMA
     'V:.. .. . .. .  .  .   'VMMV..VMMV :....:V:.:..:....::IHHHMH
       "IHH:.II:.. .:. .  . . . " :HB"" . . ..PI:.::.:::..:IHHMMV"
        :IP""HHII:.  .  .    . . .'V:. . . ..:IH:.:.::IHIHHMMMMM"
        :V:. VIMA:I..  .     .  . .. . .  .:.I:I:..:IHHHHMMHHMMM
        :"VI:.VWMA::. .:      .   .. .:. ..:.I::.:IVHHHMMMHMMMMI
        :."VIIHHMMA:.  .   .   .:  .:.. . .:.II:I:AMMMMMMHMMMMMI
        :..VIHIHMMMI...::.,:.,:!"I:!"I!"I!"V:AI:VAMMMMMMHMMMMMM'
        ':.:HIHIMHHA:"!!"I.:AXXXVVXXXXXXXA:."HPHIMMMMHHMHMMMMMV
          V:H:I:MA:W'I :AXXXIXII:IIIISSSSSSXXA.I.VMMMHMHMMMMMM
            'I::IVA ASSSSXSSSSBBSBMBSSSSSSBBMMMBS.VVMMHIMM'"'
             I:: VPAIMSSSSSSSSSBSSSMMBSSSBBMMMMXXI:MMHIMMI
            .I::. "H:XIIXBBMMMMMMMMMMMMMMMMMBXIXXMMPHIIMM'
            :::I.  ':XSSXXIIIIXSSBMBSSXXXIIIXXSMMAMI:.IMM
            :::I:.  .VSSSSSISISISSSBII:ISSSSBMMB:MI:..:MM
            ::.I:.  ':"SSSSSSSISISSXIIXSSSSBMMB:AHI:..MMM.
            ::.I:. . ..:"BBSSSSSSSSSSSSBBBMMMB:AHHI::.HMMI
            :..::.  . ..::":BBBBBSSBBBMMMB:MMMMHHII::IHHMI
            ':.I:... ....:IHHHHHMMMMMMMMMMMMMMMHHIIIIHMMV"
              "V:. ..:...:.IHHHMMMMMMMMMMMMMMMMHHHMHHMHP'
               ':. .:::.:.::III::IHHHHMMMMMHMHMMHHHHM"
                 "::....::.:::..:..::IIIIIHHHHMMMHHMV"
                   "::.::.. .. .  ...:::IIHHMMMMHMV"
                     "V::... . .I::IHHMMV"'
                       '"VHVHHHAHHHHMMV:"' 


                    WELCOME TO TROLL SLAYER!!!

END

puts Rainbow(title).tomato

end


def prompt
    clear_screen
    title_screen
    game_wait
    clear_screen
    puts Rainbow("In a world... somethingsomethingsomething...
    Defeat the Troll.\n").tomato 
    create_party
end

def create_party
    puts ("1 - ") + Rainbow("Load Game").thistle
    puts "2 - " + Rainbow("New Game").aqua
    puts "3 - " + Rainbow("Exit\n").floralwhite
    response = gets.chomp
    if response == "1"
        load_game
    elsif response == "2"
        new_game
    elsif response == "3"
        clear_screen
        exit
    else
        clear_screen
        puts "Invalid response, try again.\n\n"
        create_party
    end
end

def new_game
    print "\nName your party: "
    response = gets.chomp.downcase
    if Party.find_by(name: response)
        clear_screen
        puts Rainbow("There is already a party with that name. Be original.\n").tomato
        create_party
    else
        party = Party.create(name: response)
        start_game(party)
    end
end

def load_game
    clear_screen
    if Party.all == []
        clear_screen
        puts "No saved games!"
        game_wait
        create_party
    else
        clear_screen
        party_list = []
        Party.all.each { |party|
            party_list << party.name.capitalize
        }
        clear_screen
        puts Rainbow("What is your party's name?\n").tomato
        party_list.each { |party|
            puts party.capitalize
        }
        puts "\n"
        response = gets.chomp.downcase
        party = Party.find_by(name: response)
        if party == nil
            clear_screen
            puts Rainbow("Party not found\n").tomato
            create_party
        else
            start_game(party)
        end
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
    puts "1 - " + Rainbow("Add").salmon + "\t\t Party Member"
    puts "2 - " + Rainbow("Heal").green + "\t Party"
    puts "3 - " + Rainbow("Bury").teal + "\t Dead Member"
    puts "4 - " + Rainbow("Fight").red + "\t Monsters"
    puts "5 - " + Rainbow("View").darkkhaki + "\t Party Members"
    puts "6 - " + Rainbow("Exit\n").floralwhite
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
        if party.party_members == []
            clear_screen
            puts Rainbow("Get some party members first!\n").tomato
            game(party)
        else
            troll_hp = 100
            clear_screen
            digits = rand(1..2)
            if digits == 1
                puts Rainbow("You walk towards a field and out of a pokeball pops a troll!!!\n").darkseagreen
                puts Rainbow("You and your party have no pokeballs so your only option is to fight.").darkseagreen
            else
                puts Rainbow("As you walk through the valley of the shadow of death...").darkseagreen
                puts Rainbow("\t...something wicked this way comes.").darkseagreen
            end
            game_wait
            fight_troll(party, troll_hp)
        end
    when "5"
        #view party
        view_party(party)
    when "6"
        #exit
        exit
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
        until response.size <= 15
            puts "\nToo long. Names cannot be more than 15 characters."
            puts "What is your new party member's name?\n\n"
            response = gets.chomp.capitalize
        end
        guy = party.add_party_member(response)
        space = 6 - party.party_members.count

        rando_join_text = ["Congratulations! #{guy.name} has joined the party!", "Wait, you let #{guy.name} join??", "Hey, didn't #{guy.name} die already?", "We're unbeatable with #{guy.name}! Dattebayo!", "Wait, isn't #{guy.name} a level #{guy.level} #{guy.dnd_class.name}??", "Wow, now we have a level #{guy.level}...", "Yet another #{guy.dnd_class.name}...", "#{guy.name.capitalize} bought me some drinks so I let them join.", "Oh shit wuddup #{guy.name}?"]

        clear_screen # clears return value
        puts rando_join_text.sample
        puts ""
        if space != 0
            puts "Your party can have up to " + Rainbow(space).tomato + " more members.\n\n"
        else
            puts Rainbow("Your party is now full.\n").tomato
        end
    else
        clear_screen
        puts "Your party is full.\n\n"
    end
    game(party)
end

def print_party(party)

    party.party_members.each { |member|
        dead = ""
        hp_display = Rainbow("#{member.current_hp}/#{member.max_hp}").green
        if member.current_hp != member.max_hp
            hp_display = Rainbow(hp_display).goldenrod
        end
        if !member.alive
            dead = Rainbow(" \t*DEAD*").red
            hp_display = Rainbow(hp_display).red
        end
        member_class = member.dnd_class.name.capitalize
        if member_class == "Wizard"
            member_class = Rainbow(member_class).cyan
        else
            member_class = Rainbow(member_class).olivedrab
        end

        level_display = member.level

        if member.level < 10 
            level_display = "#{level_display} " 
        end

        puts "#{tabation(member.name)}Level #{level_display} #{member_class}\t\t\tHP: " + hp_display + "#{dead}"
    }

end

def view_party(party)
    print_party(party)
    clear_screen
    puts "#{party.name.titlecase}:\n\n"
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
        message = Spell.find_by(name: "Mass Cure Wounds").description
        clear_screen
        message.split(". ").each { |line|
            if line[-1] != "."
                line = line + "."
            end
            puts line
        }
        puts "\n"
    else
        clear_screen
        puts Rainbow("Your party has no Cleric!\n\n").tomato
    end
    game(party)
end

def party_has_cleric?(party)
    party.party_members.any? { |member|
        member.dnd_class == DndClass.find_by(name: "cleric") && member.alive
    }
end

def bury_dead(party)
    print_party(party)
    clear_screen
    puts "Sorry for your loss... get good scrub\n\n"
    
    print_party(party)
    
    puts ""
    print "Please enter the name of dead party member you wish to bury: "
    response = gets.chomp
    dead_member = party.party_members.find_by(name: response.capitalize)


    if dead_member
        dead_name = dead_member.name.dup

        if !dead_member.alive && dead_member.party == party
            dead_member.destroy
            party = updated_party(party) 
            clear_screen

            rando_eulogy = ["sad song ... poor ", "Eh, I never liked ", "Check their shoes before you bury ", "You were dead to me already, ", "It's a shame the pokecenter can't heal ", "Never forget our fallen comrade, ", "RIP "]

            puts rando_eulogy.sample + dead_name + "\n\n"
        elsif dead_member
            clear_screen
            puts "#{dead_name.capitalize} is not dead... yet.\n\n"

        end

    else

        clear_screen
        puts "Invalid input.\n\n"

    end

    game(party)

end

def fight_troll(party, troll_hp)
    
    clear_screen

    if troll_hp > 0
        
        troll_hp_text = Rainbow(troll_hp.to_s + "/100").darkseagreen

        case troll_hp
        when 20..99
            troll_hp_text = Rainbow(troll_hp_text).goldenrod
        when 2..19
            troll_hp_text = Rainbow(troll_hp_text).red
        when 1
            troll_hp_text = Rainbow(troll_hp_text).fuchsia
        else
            troll_hp_text = Rainbow(troll_hp_text).darkseagreen
        end

        puts "Troll HP:\t#{troll_hp_text}\n\n"
        puts "Menu:"
        puts "1 - " + Rainbow("Attack").tomato
        puts "2 - " + Rainbow("Run!!!").darkgoldenrod + "\tyou coward"
        puts "5 - " + Rainbow("View").darkkhaki + "\tParty Members\n\n"

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
            puts "You ran... your cow watches you in shame.\n\n"
            game_wait
    when "5"
        print_party(party)
        clear_screen
        print_party(party)
        game_wait
        fight_troll(party, troll_hp)
    else
        fight_troll(party, troll_hp)
    end
        
        party = updated_party(party)
        clear_screen
        game(party)
       
    else
        clear_screen
        #puts "congrats you win ... now like and subscribe and smash that bell!!" # doesn't trigger anyway
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
    
    cast_spell_info = cast_spell(castable.sample, rando)
    
    if cast_spell_info[0] >= troll_hp && lethal?(cast_spell_info[1])
        troll_hp = 0
    elsif cast_spell_info[0] >= troll_hp && !lethal?(cast_spell_info[1])
        troll_hp = 1
    else
        troll_hp -= cast_spell_info[0]
    end
        

end

def wiped_party(party)

    print_party(party)
    clear_screen
    puts Rainbow("Everyone has died...\n\n").tomato
    puts "The troll knew you were a scrub from the moment he laid eyes on you..."
    puts ".... look at the fools as their bodies lay on the floor...."
    puts ".... LOOK AT THEM!!!!!!"
    puts ""

    print_party(party) #losscredits??
    gets
    party.party_members.each {|member| member.destroy}
    Party.destroy(party.id)
    clear_screen
    exit

end


def troll_attack(party, troll_hp) #returns party

    
    if troll_hp < 1

        clear_screen
        puts "\n\n\n"
        puts "You got me... ugh... tell my trolls..."
        puts "I... I... ugh... x_x ....."
        puts ""
        puts Rainbow("                             #
                            ###
                           #####
                          ########
                         ##########
                        #############
                      #################
                     ###################
                   #######################
                 ############################
               ################################
             ####################################
           #######______#############______#######
          #########").limegreen + Rainbow("|").red + Rainbow("################################
         ##########").limegreen + Rainbow("|").red + Rainbow("####################").limegreen + Rainbow("|").red + Rainbow("############
         ##########").limegreen + Rainbow("|").red + Rainbow("####################").limegreen + Rainbow("|").red + Rainbow("############
         ############################################
         ############################################
         ###########____________________#############
          #########").limegreen + Rainbow("|").red + Rainbow("###################").limegreen + Rainbow("||").red + Rainbow("###########
           ########").limegreen + Rainbow("|").red + Rainbow("###################").limegreen + Rainbow("||").red + Rainbow("##########
            ###########################").limegreen + Rainbow("||").red + Rainbow("#########
               ########################").limegreen + Rainbow("||").red + Rainbow("######
                                       ").limegreen + Rainbow("||").red

        game_wait
        return party

    elsif troll_hp == 1

        clear_screen
        troll_hint

        party = rando_takes_damage(party)
        
        return party 

    else

        clear_screen

        party = rando_takes_damage(party)

    end
    

end


def cast_spell(rando_spell, rando)

    clear_screen
    puts rando_spell.description

    damage = rand(rando_spell.min_damage..rando_spell.max_damage)
    spell_name = rando_spell.name
    damage_type = rando_spell.damage_type

    if damage_type == nil
        damage_type = ""
        damage_type_string = ""
    else
        damage_type_string = " " + damage_type
    end

    case damage_type.downcase
    when "poison"
        spell_name = Rainbow(spell_name).lime
        damage_type_string = Rainbow(damage_type_string).lime
    when "acid"
        spell_name = Rainbow(spell_name).lime
        damage_type_string = Rainbow(damage_type_string).lime
    when "fire"
        spell_name = Rainbow(spell_name).red
        damage_type_string = Rainbow(damage_type_string).red
    when "radiant"
        spell_name = Rainbow(spell_name).goldenrod
        damage_type_string = Rainbow(damage_type_string).goldenrod
    when "cold"
        spell_name = Rainbow(spell_name).cyan
        damage_type_string = Rainbow(damage_type_string).cyan
    when "force"
        spell_name = Rainbow(spell_name).violet
        damage_type_string = Rainbow(damage_type_string).violet
    when "necrotic"
        spell_name = Rainbow(spell_name).darkviolet
        damage_type_string = Rainbow(damage_type_string).darkviolet
    when "psychic"
        spell_name = Rainbow(spell_name).darkviolet
        damage_type_string = Rainbow(damage_type_string).darkviolet
    when "lightning"
        spell_name = Rainbow(spell_name).gold
        damage_type_string = Rainbow(damage_type_string).gold
    when "thunder"
        spell_name = Rainbow(spell_name).gold
        damage_type_string = Rainbow(damage_type_string).gold
    else
        spell_name = Rainbow(spell_name).tomato
        damage_type_string = Rainbow(damage_type_string).tomato
    end


    puts "\n#{rando.name.capitalize}'s #{spell_name} hit the troll for #{damage}#{damage_type_string.downcase} damage."
    game_wait
    return [damage, damage_type.downcase]

end



def credits(party)

    print_party(party)
    clear_screen
    print_party(party)
    clear_screen
    puts "You find " + Rainbow("epic").darkviolet + " loot on the troll's corpse!!"
    puts "It is ....... trollsblood!!!! and an epic loin cloth!!!\n"
    puts "Thank you for playing."
    puts ""
    puts "These are the people who made this possible:"
    print_party(party)
    puts "\n\n"
    gets
    exit

end


######################### start helper methods ##########################


def lethal?(damage_type)

    weakness = ["poison", "acid", "fire"]

    return weakness.include?(damage_type)

end


def rando_takes_damage(party) #returns false if party member survies and false otherwise

    rando = party.party_members.where(alive: true).sample
    rando_damage_taken = rand(1..20)
    c_hp = rando.current_hp - rando_damage_taken
    if c_hp < 0 
        c_hp = 0
    end
    rando.update(current_hp: c_hp)
    party = updated_party(party)

    rando_quote = ["Nice one...", "Ugh...", "My turn.", "Weak...", "Take this!", ".....", "That's all you got?", "Pikachu... quick attack."].sample
    rando_damage_type = ["reddit", "touching", "love", "ruby", "slime", "spoken word", "happiness", "little bit of column A, column B"]

    clear_screen
    puts "\t\t" + "Troll: " + Rainbow(rando_quote).darkseagreen + "\n\n\n"
    puts "#{rando.name.capitalize} has taken #{rando_damage_taken} " + Rainbow(rando_damage_type.sample).darkseagreen + " damage...\n"

    if rando.current_hp < 1

        puts "\n#{rando.name.capitalize} has " + Rainbow("died").red + "..."
        puts "They were trash anyway... one less mouth to feed."
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

    print "\n\nPress #{localization} to continue... "
    gets
    clear_screen

end

def updated_party(party)

    up_party = Party.find(party.id)

    return up_party

end

def troll_hint

    puts "Troll HP:\t" + Rainbow("1/100").fuchsia
    puts ""
    puts "Ha!... you will never kill me with those puny attacks...."
    puts "only certain elements can kill me ... "
    puts "if you dont have " + Rainbow("Acid").lime + ", " + Rainbow("Poison").lime + ", or "+ Rainbow("Fire").red
    puts "it's best if you just lie down and let me touch you...consensually.. ofc"
    puts ""
    puts "MUAHAHAHAHAHAHAHA *coughs* UAHAHAHAHAHAHAHAHA"
    puts 
    puts "ROAR!"
    puts "get ready to pay the troll toll"
    game_wait

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

