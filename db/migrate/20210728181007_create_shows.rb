class CreateShows < ActiveRecord::Migration[6.1]
  def change
    create_table :shows do |t|
      t.string :title, null: false
      t.date :release_date
      t.integer :seasons
      t.integer :score
      t.datetime :deleted_at
      t.references :studio, null: false, foreign_key: true

      t.timestamps
    end
    add_index :shows, :deleted_at
  end
end
