class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :post_images, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  # refile画像アップ用のメゾット追加
  attachment :profile_image

  # バリデーション
  # 一意性を持たせる、範囲指定
  validates :name, length: { in: 2..20 }, uniqueness: true
  # 最大文字数の指定
  validates :introduction, length: { maximum: 50 }
end
