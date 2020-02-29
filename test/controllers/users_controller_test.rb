require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
   # setup a restaurant and setup login
  setup do
    @user = users(:one)
    @user.save!
    sign_in @user
    @restaurant = restaurants(:one)
    @restaurant.save!
  end
  
  # should get show page when logged in
  test "should show profile page when logged in" do
    get user_url(@user)
    assert_response :success
   end

  # should be redirected to login when user is logged out
  # and tries to access show profile page
  test "should not show profile page when logged out" do
     sign_out @user
     get user_url(@user)
   assert_redirected_to '/users/sign_in'
   end
  
  
end
