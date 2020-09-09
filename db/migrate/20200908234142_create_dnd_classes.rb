class CreateDndClasses < ActiveRecord::Migration[6.0]
  def change
    create_table :dnd_classes do |t|
      t.string :name
    end
  end
end
