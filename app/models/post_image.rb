class PostImage < ApplicationRecord
  # アソシエーション
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :onsen_images, dependent: :destroy

  # refile画像アップ用のメゾットを追加
  accepts_attachments_for :onsen_images, attachment: :image

  # バリデーション
  # 空でないか、最大文字数の指定
  validates :post_name, presence: true, length: { maximum: 30 }
  validates :caption, presence: true, length: { maximum: 200 }

  # ユーザidがfavoritesテーブル内に存在するかを調べる
  def favorited_by?(user)
    # モデルをid以外の条件で検索する場合、whereを使用
    # 全データ返ってくる
    favorites.where(user_id: user.id).exists?
  end

  def self.search(search)
    # 何か入力した場合検索結果を表示
    if search != ""
      # PostImageモデルからタイトルを検索
      PostImage.where('post_name LIKE(?)', "%#{search}%")
    else
      # 何も入力しなかった場合全ての投稿を表示
      PostImage.includes(:user)
    end
  end
end
