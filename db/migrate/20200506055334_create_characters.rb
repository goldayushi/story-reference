class CreateCharacters < ActiveRecord::Migration[5.2]
  def change
    create_table :characters do |t|
      t.string :name
      t.string :role
      t.string :position
      t.string :countory
      t.string :birthplace
      t.text :career
      t.text :person
      t.integer :appearance_chapter

      t.timestamps
    end
  end
end
