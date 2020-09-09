class CreateSpells < ActiveRecord::Migration[6.0]
  def change
    create_table :spells do |t|
      t.string :name
      t.integer :dnd_class_id
      t.integer :min_damage
      t.integer :max_damage
      t.integer :level
      t.string :damage_type
      t.string :description
    end
  end
end
