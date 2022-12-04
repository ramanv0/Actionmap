# frozen_string_literal: true

class CreateRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|
      t.string :title, null: false
      t.string :link, null: false
      t.text :description
      t.integer :rating, null: false
      t.belongs_to :user, null: false, index: true
      t.timestamps null: false
    end
  end
end
