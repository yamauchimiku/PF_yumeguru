class UsersController < ApplicationController
  def  show
    @user = User.find(params[:id])
    # ユーザーに関連付けられた投稿のみ表示
    # 一ページ分の決められた数のデータだけを、新しい順に取得するように変更
    @post_images = @user.post_images.page(params[:page]).reverse_order
  end

  def  edit
    @user = User.find(params[:id])
    # 他人のユーザー編集画面に推移できないようにする
    if @user == current_user
      render "edit"
    else
      redirect_to post_images_path
    end
  end

  def update
    @user = User.find(params[:id])
    # バリデーションの結果を表示
    if @user.update(user_params)
      # フラッシュメッセージの表示
      flash[:notice] = 'You have updated post successfully.'
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  # ユーザーデータのストロングパラメータ
  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
