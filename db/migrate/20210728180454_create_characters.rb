class CreateCharacters < ActiveRecord::Migration[6.1]
  def change
    create_table :characters do |t|
      t.string :name, null: false
      t.integer :age
      t.float :weight
      t.text :history
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :characters, :deleted_at
  end
end
