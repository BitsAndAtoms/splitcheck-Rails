require "application_system_test_case"

class VotesTest < ApplicationSystemTestCase
  setup do
    @vote = votes(:one)
  end


include ActiveJob::TestHelper
  setup do
    @restaurant = restaurants(:one) 
  end

  
  
  
 
end
