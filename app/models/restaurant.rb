class Restaurant < ApplicationRecord
     has_many :votes
     has_many :comments
     has_many :favorites
     validates :location, :title, presence: true
     
# counts the number of upvotes
def up_votes
      votes.where(value:1).count
end

# counts the number of downvotes
def get_favorites(restaurant_value,user_value)
     favorites.where(restaurant_id: restaurant_value) .where(user_id: user_value).where(value:1).count
end



# counts the number of downvotes
def down_votes
      votes.where(value:-1).count
end

# searches by location only if title is blank
def self.search_by_location_only(location)
      Restaurant.where('location LIKE ?',"%#{location}%")
end

# searches by title only if location is blank
def self.search_by_title_only(title)
      Restaurant.where('title LIKE ?',"%#{title}%")
end

# searches by title and location when both are not blank
def self.search_by_title_and_location(title,location)
      Restaurant.where('title LIKE ?',"%#{title}%") .where('location LIKE ?',"%#{location}%")  
end

# searches based on supplied parameters for search field title and location
# resorts to helper methods
def self.find_restaurants(title,location)
 if !title.blank? && !location.blank?
    Restaurant.search_by_title_and_location(title,location)
  elsif !title.blank?
    Restaurant.search_by_title_only(title)
  elsif !location.blank?
    Restaurant.search_by_location_only(location)
  else
    Restaurant.all
  end
end

end
