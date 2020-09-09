# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_08_234142) do

  create_table "dnd_classes", force: :cascade do |t|
    t.string "name"
  end

  create_table "parties", force: :cascade do |t|
    t.string "name"
  end

  create_table "party_members", force: :cascade do |t|
    t.string "name"
    t.integer "dnd_class_id"
    t.integer "party_id"
    t.integer "current_hp"
    t.integer "max_hp"
    t.integer "level"
    t.boolean "alive"
  end

  create_table "spells", force: :cascade do |t|
    t.string "name"
    t.integer "dnd_class_id"
    t.integer "min_damage"
    t.integer "max_damage"
    t.integer "level"
    t.string "damage_type"
    t.string "description"
  end

end
