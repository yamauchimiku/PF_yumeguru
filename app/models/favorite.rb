class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :post_image
  # post_image_idとuser_idの組が一組しかないようにする
  validates_uniqueness_of :post_image_id, scope: :user_id
end