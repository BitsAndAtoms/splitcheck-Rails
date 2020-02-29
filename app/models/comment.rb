class Comment < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user
  validates :body, length: {minimum: 5}, presence: true
  validates :user, presence: true
end
