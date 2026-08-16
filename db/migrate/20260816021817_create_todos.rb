class CreateTodos < ActiveRecord::Migration[8.0]
  def change
    create_table :todos do |t|
      t.string :title
      t.boolean :completed
      t.integer :priority
      t.integer :position

      t.timestamps
    end
  end
end
