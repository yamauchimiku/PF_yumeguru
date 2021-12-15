Rails.application.routes.draw do
  devise_for :users
  # ルートパスの設定
  root to: 'homes#top'
  get 'about' => 'homes#about'

  # ネストする
  resources :post_images do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
    # 全体のデータにアクションを利用するid付かない
    collection do
      get 'search'
    end

  end

  resources :users, only: [:show, :edit, :update]
end
