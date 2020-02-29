require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
   include Devise::Test::IntegrationHelpers
  
  # setup a restaurant and setup login
  setup do
  @user = users(:one)
  @user.save!
  sign_in @user
    @comment = comments(:one)
    @comment.save!
    @restaurant = restaurants(:one)
    @restaurant.save!
  end



end
