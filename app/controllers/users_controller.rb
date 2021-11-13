class UsersController < ApplicationController
  def  show
    @user = User.find(params[:id])
    @post_image = PostImage.find(params[:id])
  end

  def  edit
  end

  def  update
  end
end
