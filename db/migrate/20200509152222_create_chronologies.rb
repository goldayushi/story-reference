# frozen_string_literal: true

class CreateChronologies < ActiveRecord::Migration[5.2]
  def change
    create_table :chronologies do |t|
      t.integer :year
      t.text :japan_event
      t.text :korea_event
      t.text :china_event
      t.text :other_event

      t.timestamps
    end
  end
end
