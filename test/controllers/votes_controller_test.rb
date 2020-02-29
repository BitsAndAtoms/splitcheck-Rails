require 'test_helper'

class VotesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  # setup after login
  # intialize the vote for user number two and restaurant number one
  # vote value os 0
  setup do
    @user = users(:two)
    @user.save!
    sign_in @user
    @restaurant = restaurants(:one)
    @restaurant.save!
  end

 # test the controller to upvote a restaurant by a given user that is logged in 
  test "should up vote restaurant one by user two with 0 upvote initally" do
    post restaurants_url, params: { restaurant: { votes1: @restaurant.down_votes, location: @restaurant.location, title: @restaurant.title,votes2: @restaurant.up_votes } }
     assert_difference('Vote.where(restaurant_id: @restaurant.id, user_id: @user.id).first.value', 1) do
     get   '/votes/'+@restaurant.id.to_s+'/up_vote'
    end
  end
  
  
  # test the controller to upvote a restaurant by a given user  logged out
  test "user is logged out and trying to up vote restaurant with 0 upvote initally" do
    sign_out @user
    post restaurants_url, params: { restaurant: { votes1: @restaurant.down_votes, location: @restaurant.location, title: @restaurant.title,votes2: @restaurant.up_votes } }
     assert_redirected_to '/users/sign_in'
  end
  
  
  # test the controller to downvote a restaurant 
  test "should down vote restaurant one by user two " do
    post restaurants_url, params: { restaurant: { votes1: @restaurant.down_votes, location: @restaurant.location, title: @restaurant.title,votes2: @restaurant.up_votes } }
     assert_difference('Vote.where(restaurant_id: @restaurant.id, user_id: @user.id).first.value', -1) do
     get   '/votes/'+@restaurant.id.to_s+'/down_vote'
    end
  end
  
   # test the controller to downvote a restaurant  while logged out
  test "Down voting while logged out redirects to sign in " do
    sign_out @user
    post restaurants_url, params: { restaurant: { votes1: @restaurant.down_votes, location: @restaurant.location, title: @restaurant.title,votes2: @restaurant.up_votes } }
      assert_redirected_to '/users/sign_in'
  end
  
  
   # test the controller to upvote a restaurant twice and have vote not change
   # when user is logged in
  test "should twice up vote restaurant one by user two so that final vote is 0 " do
    post restaurants_url, params: { restaurant: { votes1: @restaurant.down_votes, location: @restaurant.location, title: @restaurant.title,votes2: @restaurant.up_votes } }
     assert_difference('Vote.where(restaurant_id: @restaurant.id, user_id: @user.id).first.value', 0) do
     2.times{get   '/votes/'+@restaurant.id.to_s+'/up_vote'}
    end
  end
  
   # test the controller to down vote a restaurant thrice and have vote = -1
   # when user is logged in
  test "should twice down vote restaurant one by user two so that final vote is -1 " do
    post restaurants_url, params: { restaurant: { votes1: @restaurant.down_votes, location: @restaurant.location, title: @restaurant.title,votes2: @restaurant.up_votes } }
     assert_difference('Vote.where(restaurant_id: @restaurant.id, user_id: @user.id).first.value', -1) do
     3.times{get   '/votes/'+@restaurant.id.to_s+'/down_vote'}
    end
  end
  
  
    # test the controller to down vote a restaurant and then upvote to have value of 1
  test "should down vote restaurant one by user two and then upvote with vote =1 " do
    post restaurants_url, params: { restaurant: { votes1: @restaurant.down_votes, location: @restaurant.location, title: @restaurant.title,votes2: @restaurant.up_votes } }
     assert_difference('Vote.where(restaurant_id: @restaurant.id, user_id: @user.id).first.value', 1) do
     get   '/votes/'+@restaurant.id.to_s+'/down_vote'
     get   '/votes/'+@restaurant.id.to_s+'/up_vote'
    end
  end
  
      # test the controller to down vote a restaurant 10 times and then upvote 10 times to have # final value as 0
  test "should down vote 10 times and upvote 10 times so that value is 0 finally" do
    post restaurants_url, params: { restaurant: { votes1: @restaurant.down_votes, location: @restaurant.location, title: @restaurant.title,votes2: @restaurant.up_votes } }
     assert_difference('Vote.where(restaurant_id: @restaurant.id, user_id: @user.id).first.value', 0) do
     10.times{get   '/votes/'+@restaurant.id.to_s+'/down_vote'}
     10.times{get   '/votes/'+@restaurant.id.to_s+'/up_vote'}
    end
  end
  
    
    # test the controller to up vote a restaurant and then downvote to have value of -1
  test "should up vote restaurant one by user two and then downvote " do
    post restaurants_url, params: { restaurant: { votes1: @restaurant.down_votes, location: @restaurant.location, title: @restaurant.title,votes2: @restaurant.up_votes } }
     assert_difference('Vote.where(restaurant_id: @restaurant.id, user_id: @user.id).first.value', -1) do
     get   '/votes/'+@restaurant.id.to_s+'/up_vote'
     get   '/votes/'+@restaurant.id.to_s+'/down_vote'
    end
  end
  
end
