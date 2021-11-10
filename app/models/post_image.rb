class PostImage < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  #refile画像アップ用のメゾットを追加
  attachment :image
end
