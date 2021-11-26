class ApplicationController < ActionController::Base
  # ログイン認証されていなければ、ログイン画面へリダイレクトする
  # topとaboutを除く
  before_action :authenticate_user!, except: [:top, :about]
  before_action :configure_permitted_parameters, if: :devise_controller?

  # ログイン後は一覧画面に推移
  def after_sign_in_path_for(resource)
    post_images_path
  end

  # nameのデータ操作を許可するアクションメソッド
  # protectedは呼び出された他のコントローラからも参照できる
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
