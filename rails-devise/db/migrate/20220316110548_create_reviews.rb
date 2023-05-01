class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :potatoes
      t.text :comments
      t.belongs_to :movie, null: false, foreign_key: true
      t.belongs_to :moviegoer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
