class PostImage < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  # refile画像アップ用のメゾットを追加
  attachment :image

  # ユーザidがfavoritesテーブル内に存在するかを調べる
  def favorited_by?(user)
    # モデルをid以外の条件で検索する場合、whereを使用
    # 全データ返ってくる
    favorites.where(user_id: user.id).exists?
  end
end