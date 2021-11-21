class OnsenImage < ApplicationRecord
  belongs_to :post_image
  # refile画像アップ用のメゾットを追加
  attachment :image
  # 空でないか
  validates :image, presence: true
end
