require 'test_helper'

class RestaurantTest < ActiveSupport::TestCase

# tests an intialized restaurant object for field validation (presence true)  
test "restaurant attributes can not be empty" do
  restaurant = Restaurant.new
  assert restaurant.invalid?
  assert restaurant.errors[:title].any?
  assert restaurant.errors[:location].any?
end

# use the restuarant one from fixture data to check that title and location are intialized #properly
test "restaurant wih title restaurant1 and location1 is initialized properly" do
  restaurant = restaurants(:one)
  assert restaurant.valid?
  assert_equal "Restaurant1",restaurant[:title]
  assert_equal "Location1",restaurant[:location]
end

# use the restuarant one from fixture data to check that title and location are intialized #properly
test "restaurant wih title restaurant2 and location2 is initialized properly" do
  restaurant = restaurants(:two)
  assert restaurant.valid?
  assert_equal "Restaurant2",restaurant[:title]
  assert_equal "Location2",restaurant[:location]
end

# checks if 3 votes can be accumulated
test "restaurant has three(many) votes" do
restaurant2 = restaurants(:two)
user1 = users(:one)
user2 = users(:two)
user3 = users(:three)
Vote.where(:restaurant_id => restaurant2.id).destroy_all
vote = Vote.create(:value => 1, :user_id => user1.id,:restaurant_id => restaurant2.id);
vote2 = Vote.create(:value => 0, :user_id => user2.id,:restaurant_id => restaurant2.id);
vote3 = Vote.create(:value => 0, :user_id => user3.id,:restaurant_id => restaurant2.id);
assert_equal(3,restaurant2.votes.size,"The accumulation of votes is not correct")
end

# check boundary case of one vote only
test "restaurant has one vote" do
restaurant2 = restaurants(:two)
user1 = users(:one)
Vote.where(:restaurant_id => restaurant2.id).destroy_all
vote = Vote.create(:value => 1, :user_id => user1.id,:restaurant_id => restaurant2.id);
assert_equal(1,restaurant2.votes.size,"The accumulation of votes is not correct")
end

# check restaurant can be favorited
test "restaurant has been favourited" do
restaurant2 = restaurants(:two)
user1 = users(:one)
Favorite.where(:restaurant_id => restaurant2.id).destroy_all
favorite = Favorite.create(:value => 1, :user_id => user1.id,:restaurant_id => restaurant2.id);
assert_equal(1,favorite.value,"The value of favourite is 1")
assert_equal(1,restaurant2.favorites.first.value,"The favorite value has correct restaurant and user")
end


# check restaurant can be favorited by many users
test "restaurant has been favourited by two users" do
restaurant2 = restaurants(:two)
user1 = users(:one)
user2 = users(:two)
Favorite.where(:restaurant_id => restaurant2.id).destroy_all
favorite = Favorite.create(:value => 1, :user_id => user1.id,:restaurant_id => restaurant2.id);
favorite = Favorite.create(:value => 1, :user_id => user2.id,:restaurant_id => restaurant2.id);
assert_equal(2,restaurant2.favorites.count,"Two times favorited restaurant")
end


# check restaurant can be un favorited
test "restaurant can be unfavourited" do
restaurant2 = restaurants(:two)
user1 = users(:one)
Favorite.where(:restaurant_id => restaurant2.id).destroy_all
favorite = Favorite.create(:value => 1, :user_id => user1.id,:restaurant_id => restaurant2.id);
Favorite.update_favorite(1,restaurant2.id,user1.id);
assert_equal(0,Favorite.where(:restaurant_id => restaurant2.id).where(:user_id => user1.id).count,"A favorite for restrurant id and user id should not exist as it is destroyed")
end

# check restaurant can have comment
test "restaurant can be commented upon" do
restaurant2 = restaurants(:two)
user1 = users(:one)
Comment.where(:restaurant_id => restaurant2.id).destroy_all
comment = Comment.create(:body => "input new text", :user_id => user1.id,:restaurant_id => restaurant2.id);
assert_equal("input new text",restaurant2.comments.first.body,"A favorite for restrurant id and user id should not exist as it is destroyed")
end


# check restaurant can have comment
test "restaurant can have many comments" do
restaurant2 = restaurants(:two)
user1 = users(:one)
Comment.where(:restaurant_id => restaurant2.id).destroy_all
comment = Comment.create(:body => "input new text", :user_id => user1.id,:restaurant_id => restaurant2.id);
comment = Comment.create(:body => "input new text2", :user_id => user1.id,:restaurant_id => restaurant2.id);
assert_equal("input new text2",restaurant2.comments.second.body,"Restaurant can have second comment")
assert_equal("input new text",restaurant2.comments.first.body,"Comment number one was appended")
assert_equal(2,restaurant2.comments.count,"There are total two comments")
end

# check case with not votes
test "restaurant has zero vote" do
restaurant2 = restaurants(:two)
Vote.where(:restaurant_id => restaurant2.id).destroy_all
assert_equal(0,restaurant2.votes.size,"The accumulation of votes is not correct")
end

# check searching by location only
test "restaurant search by location only" do
restaurant = Restaurant.search_by_location_only("Location2").first
assert_equal "Restaurant2",restaurant[:title]
assert_equal "Location2",restaurant[:location]
end

# check searching by title only
test "restaurant search by title only" do
restaurant = Restaurant.search_by_title_only("Restaurant2").first
assert_equal "Restaurant2",restaurant[:title]
assert_equal "Location2",restaurant[:location]
end

test "restaurant search by title and location" do
restaurant = Restaurant.search_by_title_and_location("Restaurant1","Location1").first
assert_equal "Restaurant1",restaurant[:title]
assert_equal "Location1",restaurant[:location]
end

# check searching by one search parameter while other is emtpy
test "find restaurants with only one search parameter" do
restaurant = Restaurant.find_restaurants("","Location1").first
assert_equal "Restaurant1",restaurant[:title]
assert_equal "Location1",restaurant[:location]
end

# check with two acceptable search parameters of the same restaurant
test "find restaurants with  two search parameters" do
restaurant = Restaurant.find_restaurants("Restaurant1","Location1").first
assert_equal "Restaurant1",restaurant[:title]
assert_equal "Location1",restaurant[:location]
end

# check with faulty data to return nil
test "find restaurants returns empty for invalid search parameters" do
restaurant = Restaurant.find_restaurants("abc","def").first
assert_nil restaurant
end

end
