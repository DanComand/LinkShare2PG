class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.string :url
      t.text :description
      t.integer :user_id
      t.string :title
      t.string :image
      t.integer :list_id
      t.string :summary

      t.timestamps null: false
    end
  end
end
