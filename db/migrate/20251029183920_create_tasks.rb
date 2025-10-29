class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.references :project, null: false, foreign_key: true
      t.string :title, null: false
      t.text :description
      t.string :status, null: false, default: 'pending'
      t.references :creator, null: false, foreign_key: { to_table: :users }
      t.references :assigned_user, null: true, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :tasks, :status
  end
end
