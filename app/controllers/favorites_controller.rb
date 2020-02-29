class FavoritesController < ApplicationController
   before_action :authenticate_user!

   # method that favotites the chosen resturant
   # procceds to update the vote
   def select_favorite
       Favorite.update_favorite(1,params[:id],current_user.id)
       redirect_back(fallback_location: restaurants_url)
   end

   private
   
   # helper method to favorite the restro
 
 
end
