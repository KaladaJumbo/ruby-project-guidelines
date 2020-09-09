DndClass.destroy_all
Party.destroy_all
PartyMember.destroy_all
Spell.destroy_all

DndClass.find_or_create_by(name: "wizard")
DndClass.find_or_create_by(name: "cleric")

load_api

team_rocket = Party.find_or_create_by(name: "team rocket")

team_rocket.add_party_member("Ash Ketchum")
team_rocket.add_party_member("Jessie")
team_rocket.add_party_member("James")