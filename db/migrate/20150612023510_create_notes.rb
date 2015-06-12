class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :comment
      t.integer :bookmark_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
