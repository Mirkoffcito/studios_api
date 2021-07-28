class CreateRoles < ActiveRecord::Migration[6.1]
  def change
    create_table :roles do |t|
      t.references :movie, null: false, foreign_key: true
      t.references :show, null: false, foreign_key: true
      t.references :character, null: false, foreign_key: true
      t.references :studio, null: false, foreign_key: true

      t.timestamps
    end
  end
end
