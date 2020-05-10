class CreateGlossaries < ActiveRecord::Migration[5.2]
  def change
    create_table :glossaries do |t|
      t.string :title
      t.text :content
      t.integer :chapter

      t.timestamps
    end
  end
end
