class ApplicationController < ActionController::Base

rescue_from ActiveRecord::RecordNotFound, :with => :handling

def handling
 render :file => "#{Rails.root}/public/404.html", layout: false, status: :not_found
end


end
