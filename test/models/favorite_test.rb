require 'test_helper'

class FavoriteTest < ActiveSupport::TestCase
 
 #  favorite attribute can not be empty
test "favorite attributes can not be empty" do
  favorite = Favorite.new
  assert favorite.invalid?
  assert favorite.errors[:value].any?
  assert favorite.errors[:user].any?
  assert favorite.errors[:restaurant].any?
end
 
 # integer value of 1 is allowed for favorite value
test "favorite value can be positive unity" do
  favorite = favorites(:one)
  assert favorite.valid?
end

# integer value of minus 1 is not allowed for favorite 
test "favorite value can not be negative unity" do
  restaurant2 = restaurants(:two)
  user1 = users(:one)
  Favorite.where(:restaurant_id => restaurant2.id).destroy_all
  favorite = Favorite.create(:value => -1, :user_id => user1.id,:restaurant_id => restaurant2.id);
  assert favorite.invalid?
end


# favorite value larger than one is not allowed
test "favorite value can not be greater than one" do
  restaurant2 = restaurants(:two)
  user1 = users(:one)
  Favorite.where(:restaurant_id => restaurant2.id).destroy_all
  favorite = Favorite.create(:value => 10, :user_id => user1.id,:restaurant_id => restaurant2.id);
  assert favorite.invalid?
end

# favorite value less than 0 is not allowed
test "favorite value less than o is not allowed" do
  restaurant2 = restaurants(:two)
  user1 = users(:one)
  Favorite.where(:restaurant_id => restaurant2.id).destroy_all
  favorite = Favorite.create(:value => -10, :user_id => user1.id,:restaurant_id => restaurant2.id);
  assert favorite.invalid?
end
 
 
# check tha update favorite method works by favoriting a restaurant
test "update favorite method works" do
restaurant2 = restaurants(:two)
user1 = users(:one)
Favorite.where(:restaurant_id => restaurant2.id).destroy_all
Favorite.update_favorite(1,restaurant2.id,user1.id)
assert_equal(1,restaurant2.favorites.first.value,"Favorite value of 1 is created fro given restaurant and user")
end


# checkupdate favorite method works by favoriting a restaurant twice
test "update favorite two times" do
restaurant2 = restaurants(:two)
user1 = users(:one)
user2 = users(:two)
Favorite.where(:restaurant_id => restaurant2.id).destroy_all
Favorite.update_favorite(1,restaurant2.id,user1.id)
Favorite.update_favorite(1,restaurant2.id,user2.id)
assert_equal(2,restaurant2.favorites.count,"Favorited twice")
end


# update favorite can be used to unfavorite
test "update favorite can be used to unfavorite" do
restaurant2 = restaurants(:two)
user1 = users(:one)
Favorite.where(:restaurant_id => restaurant2.id).destroy_all
Favorite.update_favorite(1,restaurant2.id,user1.id)
Favorite.update_favorite(1,restaurant2.id,user1.id);
assert_equal(0,restaurant2.favorites.count,"Restaurant is unfavorited")
end
 
 
end
