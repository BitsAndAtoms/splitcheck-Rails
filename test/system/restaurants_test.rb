require "application_system_test_case"

class RestaurantsTest < ApplicationSystemTestCase
include ActiveJob::TestHelper
  setup do
    @restaurant = restaurants(:one) 
  end

  test "visiting the index" do
  visit restaurants_url
  assert_selector "h1", text: "🥂 Restaurants for the Split! 🍔"
  end
  
  
  test "Do successful login" do
    visit restaurants_url
    click_on "Login"
    fill_in "Email", with: 'user1@email.com'
    fill_in "Password", with: '123greetings1'
    click_button "Log in"
    assert_text "Signed in successfully"
  end
  
  test "Do successful logout" do
    visit restaurants_url
    click_on "Login"
    fill_in "Email", with: 'user1@email.com'
    fill_in "Password", with: '123greetings1'
    click_button "Log in"
    assert_text "Signed in successfully"
    click_on "Logout"
    assert_text "Signed out successfully"
  end
  
  test "Do successful signup" do
     visit restaurants_url
    click_on "Sign Up"
    fill_in "Email", with: 'xyz@email.com'
    fill_in "Password", with: 'xyzxyz'
    fill_in "Password confirmation", with: 'xyzxyz'
    click_button "Sign up"
    assert_text "Welcome! You have signed up successfully."
  end
  
   test "creating a Restaurant" do
    visit restaurants_url
    click_on "Login"
    fill_in "Email", with: 'user1@email.com'
    fill_in "Password", with: '123greetings1'
    click_button "Log in"
    click_on "New"
    fill_in "restaurant_title", with: 'The American'
    fill_in "restaurant_location", with: 'Paris'
    click_button "Create Restaurant"
    assert_text "Restaurant was successfully created."
  end
  
  test "updating a Restaurant" do
   visit restaurants_url
    click_on "Login"
    fill_in "Email", with: 'user1@email.com'
    fill_in "Password", with: '123greetings1'
    click_button "Log in"
     click_on "Edit", match: :first
    fill_in "restaurant_title", with: 'Remington'
    fill_in "restaurant_location", with: 'Los Alamo'
     click_on "Update Restaurant"
    assert_text "Restaurant was successfully updated."
  end

test "creating a Restaurant without loging in redirects to login" do
    visit restaurants_url
    click_on "New"
     assert_selector "h2", text: "Log in"
  end



 
end
