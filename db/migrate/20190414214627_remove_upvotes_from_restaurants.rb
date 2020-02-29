class RemoveUpvotesFromRestaurants < ActiveRecord::Migration[5.2]
  def change
    remove_column :restaurants, :upvotes, :integer
  end
end
