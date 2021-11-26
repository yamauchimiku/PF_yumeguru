class OnsenImage < ApplicationRecord
  # アソシエーション
  belongs_to :post_image

  # refile画像アップ用のメゾットを追加
  attachment :image

  # バリデーション
  # 空でないか
  validates :image, presence: true
end
