class CreateStudios < ActiveRecord::Migration[6.1]
  def change
    create_table :studios do |t|
      t.string :name
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :studios, :deleted_at
  end
end
