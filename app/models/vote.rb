class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  validates :value, inclusion: { in: -1..1 , message: "Vote value is not valid"}, presence: true
  
  
  def self.update_vote(new_value,restaurant_id, current_user_id)
        @restaurant = Restaurant.find(restaurant_id)
        @vote = @restaurant.votes.where(user_id: current_user_id).first
        if @vote
          if(@vote[:value] == new_value)
           new_value = 0;
          end
            @vote.update_attribute(:value, new_value)
        else
            @current_user = User.find(current_user_id)
            @vote = @current_user.votes.create(value: new_value, restaurant: @restaurant)
        end
     end
  
end
