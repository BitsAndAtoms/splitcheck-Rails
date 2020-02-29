class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # POST /comments
  # POST /comments.json
  def create
     @restaurant = Restaurant.find(params[:restaurant_id])
        comment = @restaurant.comments.new(comment_params)
        comment.user_id = current_user.id
        if comment.save
            flash[:notice] = "Commented successfully"
             redirect_to restaurants_url
        else
         flash[:alert] = "Comment needs to be atleast five characters long"
            redirect_to new_comment_restaurant_path(@restaurant)   
     end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:body)
    end
end
