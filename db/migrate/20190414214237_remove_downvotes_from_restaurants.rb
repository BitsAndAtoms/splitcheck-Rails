class RemoveDownvotesFromRestaurants < ActiveRecord::Migration[5.2]
  def change
    remove_column :restaurants, :downvotes, :integer
  end
end
