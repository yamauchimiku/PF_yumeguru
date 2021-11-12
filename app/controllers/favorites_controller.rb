class FavoritesController < ApplicationController
  def  create
    @post_image = PostImage.find(params[:post_image_id])
    # idを二つ指定
    favorite = current_user.favorites.new(post_image_id: @post_image.id)
    favorite.save
    # app/views/favorites/create.js.erbを参照する
  end

  def destroy
    @post_image = PostImage.find(params[:post_image_id])
    favorite = current_user.favorites.find_by(post_image_id: @post_image.id)
    favorite.destroy
    # app/views/favorites/destroy.js.erbを参照する
  end
end