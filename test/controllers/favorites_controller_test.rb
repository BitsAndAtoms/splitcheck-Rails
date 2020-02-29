require 'test_helper'

class FavoritesControllerTest < ActionDispatch::IntegrationTest
include Devise::Test::IntegrationHelpers

  setup do
    @favorite = favorites(:one)
  end

# should favorite a restaurant when logged in the system
  test "should favorite a resturant when logged in" do
    @user = users(:one)
    @user.save!
    sign_in @user
    @restaurant = restaurants(:one)
    @restaurant.save!
    Favorite.where(:restaurant_id => @restaurant.id).destroy_all
    
     post restaurants_url, params: { restaurant: { fav1: @restaurant.get_favorites(@restaurant.id,@user.id), location: @restaurant.location, title: @restaurant.title } }
     
     assert_difference('Favorite.where(restaurant_id: @restaurant.id, user_id: @user.id).count', 1) do
     get   '/favorites/'+@restaurant.id.to_s+'/select_favorite'
    end 
  end
  
 # should unfavorite an already favorited restaurant when logged in the system 
  test "should unfavorite a resturant when logged in" do
    @user = users(:one)
    @user.save!
    sign_in @user
    @restaurant = restaurants(:one)
    @restaurant.save!
    
     post restaurants_url, params: { restaurant: { fav1: @restaurant.get_favorites(@restaurant.id,@user.id), location: @restaurant.location, title: @restaurant.title } }
     
     assert_difference('Favorite.where(restaurant_id: @restaurant.id, user_id: @user.id).count', -1) do
     get   '/favorites/'+@restaurant.id.to_s+'/select_favorite'
    
    end 
  end
  
  
   # should not be able to favortite/unfavorite when logged out
   # and will be directed to sign in
  test "should not be able to use favorite when logged out" do
    @user = users(:one)
    @user.save!
    @restaurant = restaurants(:one)
    @restaurant.save!
    
     post restaurants_url, params: { restaurant: { fav1: @restaurant.get_favorites(@restaurant.id,@user.id), location: @restaurant.location, title: @restaurant.title } }
     
     assert_redirected_to '/users/sign_in'
  end
  
 
end
