class UsersController < ApplicationController
  def  show
    @user = User.find(params[:id])
    # ユーザーに関連付けられた投稿のみ表示
    @post_images = @user.post_images.page(params[:page]).reverse_order
  end

  def  edit
    @user = User.find(params[:id])
  end

  def  update
    @user = User.find(params[:id])
    if  @user.update(user_params)
      flash[:notice] = 'You have updated post successfully!!'
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end

