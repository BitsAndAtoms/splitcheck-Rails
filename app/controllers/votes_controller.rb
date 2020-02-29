class VotesController < ApplicationController
  before_action :authenticate_user!

   # up_vote aims to vote +1 for the chosen resturant
   # procceds to update the vote
   def up_vote
       Vote.update_vote(1,params[:id],current_user.id)
       redirect_back(fallback_location: restaurants_url)
   end
  
   # down_vote aims to vote 11 for the chosen resturant
   # procceds to update the vote
   def down_vote
     Vote.update_vote(-1,params[:id],current_user.id)
     redirect_back(fallback_location: restaurants_url)
   end

   private
   
     
   end
