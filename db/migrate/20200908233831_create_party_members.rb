class CreatePartyMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :party_members do |t|
      t.string :name
      t.integer :dnd_class_id
      t.integer :party_id
      t.integer :current_hp
      t.integer :max_hp
      t.integer :level
      t.boolean :alive
    end
  end
end
