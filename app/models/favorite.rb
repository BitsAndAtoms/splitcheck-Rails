class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  validates :value, inclusion: { in: 0..1 , message: "Vote value is not valid"}, presence: true
  
  
      def self.update_favorite(new_value,restaurant_id, current_user_id)
        @restaurant = Restaurant.find(restaurant_id)
        @favorite = @restaurant.favorites.where(user_id: current_user_id).first
        if @favorite
          if(@favorite[:value] == new_value)
           @favorite.destroy
          else
            @favorite.update_attribute(:value, new_value)
          end
        else
        @current_user = User.find(current_user_id)
            @favorite = @current_user.favorites.create(value: new_value, restaurant: @restaurant)
        end
     end
  
  
  
end
