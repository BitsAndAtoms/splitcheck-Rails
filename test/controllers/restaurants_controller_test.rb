require 'test_helper'

class RestaurantsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  # setup a restaurant and setup login
  setup do
  @user = users(:one)
  @user.save!
  sign_in @user
    @restaurant = restaurants(:one)
    @restaurant.save!
  end

  # should get index page
  test "should get index" do
    get restaurants_url
    assert_response :success
  end
  
   # should not be redirected to login when user is logged out
   # and tries to access show pagee
  test "should show listing even when logged out" do
     sign_out @user
     get restaurant_url(@restaurant)
     assert_response :success
   end
 
   # should  show page with restaurant listing when logged in
  test "should show listings when logged in" do
     get restaurant_url(@restaurant)
     assert_response :success
   end

  # should create a restaurant when logged in
  test "should create restaurant when logged in" do
    assert_difference('Restaurant.count') do
      post restaurants_url, params: { restaurant: { votes1: @restaurant.down_votes, location: @restaurant.location, title: @restaurant.title, votes2: @restaurant.up_votes } }
    end

    assert_redirected_to restaurants_url
  end
  
  # should not create a restaurant when logged out
  test "should not create restaurant when logged out" do
    sign_out @user
    assert_difference('Restaurant.count',0) do
      post restaurants_url, params: { restaurant: { votes1: @restaurant.down_votes, location: @restaurant.location, title: @restaurant.title, votes2: @restaurant.up_votes } }
    end

    assert_redirected_to '/users/sign_in'
  end

  
  # should edit restaurant when logged in
  test "should get edit when logged in" do
    get edit_restaurant_url(@restaurant)
    assert_response :success
  end
  
  # should not be able to edit restaurant when logged out
  test "should not edit when logged out" do
  sign_out @user
    get edit_restaurant_url(@restaurant)
   assert_redirected_to '/users/sign_in'
  end

 # should update restaurant when logged in
  test "should update restaurant" do
    patch restaurant_url(@restaurant), params: { restaurant: { votes1: @restaurant.down_votes, location: @restaurant.location, title: @restaurant.title, votes2: @restaurant.up_votes } }
    assert_redirected_to restaurants_url
  end
  
   # should not update restaurant when logged out
  test "should not update restaurant when logged out" do
  sign_out @user
    patch restaurant_url(@restaurant), params: { restaurant: { votes1: @restaurant.down_votes, location: @restaurant.location, title: @restaurant.title, votes2: @restaurant.up_votes } }
    assert_redirected_to '/users/sign_in'
  end


end
