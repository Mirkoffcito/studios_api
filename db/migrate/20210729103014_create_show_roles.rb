class CreateShowRoles < ActiveRecord::Migration[6.1]
  def change
    create_table :show_roles do |t|
      t.references :show, null: false, foreign_key: true
      t.references :character, null: false, foreign_key: true

      t.timestamps
    end
  end
end
