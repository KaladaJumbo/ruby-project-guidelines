DndClass.destroy_all
Party.destroy_all
PartyMember.destroy_all
Spell.destroy_all

DndClass.find_or_create_by(name: "wizard")
DndClass.find_or_create_by(name: "cleric")

load_api
