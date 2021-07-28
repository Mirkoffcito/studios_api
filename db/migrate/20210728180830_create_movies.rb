class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :title, null: false
      t.date :release_date
      t.integer :score
      t.datetime :deleted_at
      t.references :studio, null: false, foreign_key: true

      t.timestamps
    end
    add_index :movies, :deleted_at
  end
end
