# frozen_string_literal: true

class CreateEpisodes < ActiveRecord::Migration[5.2]
  def change
    create_table :episodes do |t|
      t.integer :chapter
      t.string :title
      t.text :overview
      t.text :content
      t.string :set
      t.string :keyword
      t.string :keyitem
      t.string :division
      t.integer :year

      t.timestamps
    end
  end
end
