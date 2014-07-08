class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.text :content
      t.integer :user_id

      t.timestamps
    end
    add_index :Entries, [:user_id, :created_at]
  end
end
