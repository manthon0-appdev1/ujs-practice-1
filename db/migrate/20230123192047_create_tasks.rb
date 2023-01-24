class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.text :body, null: false
      t.integer :status, default: 0
      t.references :owner, null: false, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
