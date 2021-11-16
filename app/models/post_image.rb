class PostImage < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :onsen_images, dependent: :destroy

  # refile画像アップ用のメゾットを追加
  accepts_attachments_for :onsen_images, attachment: :image

  # バリデーション
  validates :post_name, presence: true

  # ユーザidがfavoritesテーブル内に存在するかを調べる
  def favorited_by?(user)
    # モデルをid以外の条件で検索する場合、whereを使用
    # 全データ返ってくる
    favorites.where(user_id: user.id).exists?
  end
end
