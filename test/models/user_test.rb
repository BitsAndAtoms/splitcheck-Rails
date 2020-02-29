require 'test_helper'

class UserTest < ActiveSupport::TestCase

# test to check that invalid user attribute throws error
test "user attributes can not be empty" do
  user = User.new
  assert user.invalid?
  assert user.errors[:email].any?
end

# test on the user one from fixture data to validate user email initialization
test "user wih valid email user@email.com is initialized properly" do
  user = users(:one)
  assert user.valid?
  assert_equal "user@email.com",user[:email]
end

# checks to see if user can accumulte votes (has_many)
test "user has cast three (many) votes" do
  user1 = users(:one)
  restaurant1 = restaurants(:one)
  restaurant2 = restaurants(:two)
  restaurant3 = restaurants(:three)
  Vote.where(:user_id => user1.id).destroy_all
  vote1 = Vote.create(:value => 1, :user_id => user1.id,:restaurant_id => restaurant1.id);
  vote2 = Vote.create(:value => 0, :user_id => user1.id,:restaurant_id => restaurant2.id);
  vote3 = Vote.create(:value => 0, :user_id => user1.id,:restaurant_id => restaurant3.id);
  assert_equal(3,user1.votes.size,"not goood")
end

# checks to see the boundary condition of a single vote case by user
test "user has cast one vote" do
  user1 = users(:one)
  restaurant1 = restaurants(:one)
  Vote.where(:user_id => user1.id).destroy_all
  vote = Vote.create(:value => 1, :user_id => user1.id,:restaurant_id => restaurant1.id);
  assert_equal(1,user1.votes.size,"not goood")
end

# checks to see if user can have zero votes
test "user has cast zero votes" do
  user1 = users(:one)
  Vote.where(:user_id => user1.id).destroy_all
  assert_equal(0,user1.votes.size,"not goood")
end

# checks to see that a user can have comments
test "user has comments" do
  user1 = users(:one)
  restaurant1 = restaurants(:one)
  Comment.where(:user_id => user1.id).destroy_all
  Comment.create(:body => "comment1", :user_id => user1.id,:restaurant_id => restaurant1.id);
    Comment.create(:body => "comment2", :user_id => user1.id,:restaurant_id => restaurant1.id);
    Comment.create(:body => "comment3", :user_id => user1.id,:restaurant_id => restaurant1.id);
  assert_equal(3,user1.comments.size,"Correct number of comments")
end

# checks to see that a user can have favorites
test "user has favorites" do
  user1 = users(:one)
  restaurant1 = restaurants(:one)
  restaurant2 = restaurants(:two)
  restaurant3 = restaurants(:three)
  Favorite.where(:user_id => user1.id).destroy_all
  Favorite.create(:value => 1, :user_id => user1.id,:restaurant_id => restaurant1.id);
    Favorite.create(:value => 1, :user_id => user1.id,:restaurant_id => restaurant2.id);
   Favorite.create(:value => 1, :user_id => user1.id,:restaurant_id => restaurant3.id);
  assert_equal(3,user1.favorites.size,"Correct number of comments")
end

end
