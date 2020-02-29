require 'test_helper'

class CommentTest < ActiveSupport::TestCase
 
 # comment attribute can not be empty
test "comment attributes can not be empty" do
  comment = Comment.new
  assert comment.invalid?
  assert comment.errors[:user].any?
  assert comment.errors[:body].any?
end


 # body length of comment text can not be less than five characters
test "comment attributes can not be less than five characters" do
  restaurant2 = restaurants(:two)
  user1 = users(:one)
  comment = Comment.create(:body => "1234", :user_id => user1.id,:restaurant_id => restaurant2.id)
  assert comment.invalid?
  assert comment.errors[:body].any?
end

 # body length of comment text of five characters is acceptable
test "comment attributes need to be atelast five characters" do
  restaurant2 = restaurants(:two)
  user1 = users(:one)
  comment = Comment.create(:body => "12345", :user_id => user1.id,:restaurant_id => restaurant2.id)
  assert comment.valid?
end

 # Single comment of "good restaurant" is made
test "check single comment on restaurant" do
  restaurant2 = restaurants(:two)
  user1 = users(:one)
  Comment.where(:restaurant_id => restaurant2.id).destroy_all
  comment = Comment.create(:body => "good restaurant", :user_id => user1.id,:restaurant_id => restaurant2.id)
  assert_equal "good restaurant",restaurant2.comments.first.body
end

# Two comments are made by same user
test "check two comments on restaurant by same user" do
  restaurant2 = restaurants(:two)
  user1 = users(:one)
  Comment.where(:restaurant_id => restaurant2.id).destroy_all
  comment = Comment.create(:body => "good restaurant", :user_id => user1.id,:restaurant_id => restaurant2.id)
  Comment.create(:body => "Bad restaurant", :user_id => user1.id,:restaurant_id => restaurant2.id)
  assert_equal "good restaurant",restaurant2.comments.first.body
  assert_equal "Bad restaurant",restaurant2.comments.second.body
  assert_equal 2,restaurant2.comments.count
end
 
# Two comments are made by a user
test "check two comments by single user" do
  restaurant2 = restaurants(:two)
  user1 = users(:one)
  Comment.where(:user_id => user1.id).destroy_all
  Comment.create(:body => "good restaurant", :user_id => user1.id,:restaurant_id => restaurant2.id)
  Comment.create(:body => "Bad restaurant", :user_id => user1.id,:restaurant_id => restaurant2.id)
  assert_equal "good restaurant",user1.comments.first.body
  assert_equal "Bad restaurant",user1.comments.second.body
  assert_equal 2,user1.comments.count
end

# user comments "very good" on restaurant
test "check text of comment by user" do
  restaurant2 = restaurants(:two)
  user1 = users(:one)
  Comment.where(:user_id => user1.id).destroy_all
  Comment.create(:body => "very good", :user_id => user1.id,:restaurant_id => restaurant2.id)
  assert_equal "very good",user1.comments.first.body

end
 
 
 
 
end
