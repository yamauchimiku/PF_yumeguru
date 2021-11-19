class FavoritesController < ApplicationController
  def create
    # @を付与
    @post_image = PostImage.find(params[:post_image_id])
    # idを二つ指定
    favorite = @post_image.favorites.new(user_id: current_user.id)
    favorite.save
    # app/views/favorites/create.js.erbを参照する
  end

  def destroy
    # @を付与
    @post_image = PostImage.find(params[:post_image_id])
    favorite = @post_image.favorites.find_by(user_id: current_user.id)
    favorite.destroy
    # app/views/favorites/destroy.js.erbを参照する
  end
end
