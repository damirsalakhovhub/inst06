class CreateProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :projects do |t|
      t.references :organization, null: false, foreign_key: true
      t.string :name, null: false
      t.text :description

      t.timestamps
    end
  end
end
