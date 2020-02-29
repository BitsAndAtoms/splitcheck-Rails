class AddIndex < ActiveRecord::Migration[5.2]
  def change
  add_index :favorites, [:user_id,:restaurant_id], unique: true
  end
end
