require 'test_helper'

class VoteTest < ActiveSupport::TestCase

# vote attribute can not be empty
test "vote attributes can not be empty" do
  vote = Vote.new
  assert vote.invalid?
  assert vote.errors[:value].any?
end

# integer value of 1 is allowed for vote value
test "vote value can be positive unity" do
  vote = votes(:one)
  assert vote.valid?
end

# integer value of minus 1 is allowed for vote 
test "vote value can be negative unity" do
  vote = votes(:two)
  assert vote.valid?
end

# vote value can be 0
test "vote value can be zero" do
  vote = votes(:three)
  assert vote.valid?
end

# vote value larger than one is not allowed
test "vote value can not be greater than one" do
  vote = votes(:four)
  assert vote.invalid?
  assert_equal ["Vote value is not valid"],vote.errors[:value]
end

# vote value larger than minus one is not allowed
test "vote value can not be less than minus one" do
  vote = votes(:five)
  assert vote.invalid?
  assert_equal ["Vote value is not valid"],vote.errors[:value]
end

# test for count of upvote and of total votes
test "Total upvotes for a restaurant are 2 and total votes are also two" do
restaurant2 = restaurants(:two)
user1 = users(:one)
user2 = users(:two)
Vote.where(:restaurant_id => restaurant2.id).destroy_all
Vote.update_vote(1,restaurant2.id,user1.id)
Vote.update_vote(1,restaurant2.id,user2.id)
assert_equal 2,restaurant2.up_votes
assert_equal 2,restaurant2.votes.count
end

# test for count of downvote and downvote is 1,1 and of total votes is 2
test "one downvotes and one upvote and 2 total votes" do
restaurant2 = restaurants(:two)
user1 = users(:one)
user2 = users(:two)
Vote.where(:restaurant_id => restaurant2.id).destroy_all
Vote.update_vote(1,restaurant2.id,user1.id)
Vote.update_vote(-1,restaurant2.id,user2.id)
assert_equal 1,restaurant2.up_votes
assert_equal 1,restaurant2.down_votes
assert_equal 2,restaurant2.votes.count
end

# test for Up_date vote method, upvote then dunvote then downvote the upvote
test "vote can be upvoted, unvoted, downvoted and upvoted" do
restaurant2 = restaurants(:two)
user1 = users(:one)
Vote.where(:restaurant_id => restaurant2.id).destroy_all
Vote.update_vote(1,restaurant2.id,user1.id)
assert_equal 1,restaurant2.up_votes
Vote.update_vote(1,restaurant2.id,user1.id)
assert_equal 0,restaurant2.up_votes
Vote.update_vote(-1,restaurant2.id,user1.id)
assert_equal 1,restaurant2.down_votes
Vote.update_vote(1,restaurant2.id,user1.id)
assert_equal 1,restaurant2.up_votes
end


# test for vote count
test "Votes can be upvoted total 3 times with 0 downvote" do
restaurant2 = restaurants(:two)
user1 = users(:one)
user2 = users(:two)
user3 = users(:three)
Vote.where(:restaurant_id => restaurant2.id).destroy_all
Vote.update_vote(1,restaurant2.id,user1.id)
Vote.update_vote(1,restaurant2.id,user2.id)
Vote.update_vote(1,restaurant2.id,user3.id)
assert_equal 0,restaurant2.down_votes
assert_equal 3,restaurant2.up_votes
end


end
