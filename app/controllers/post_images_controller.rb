class PostImagesController < ApplicationController
  def  new
    @post_image = PostImage.new
  end

  def  create
    @post_image = PostImage.new(post_image_params)
    # deviseのヘルパーメゾット
    @post_image.user_id = current_user.id
    @post_image.save
    redirect_to post_images_path
  end

  def  index
    # 一ページ分の決められた数のデータだけを、新しい順に取得するように変更
    @post_images = PostImage.page(params[:page]).reverse_order
  end

  def  show
    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new
  end

  def  edit
    @post_image = PostImage.find(params[:id])
  end

  def  update
    @post_image = PostImage.find(params[:id])
    @post_image.update(post_image_params)
    redirect_to post_image_path(@post_image.id)
  end

  def  destroy
    @post_image = PostImage.find(params[:id])
    @post_image.destroy
    redirect_to post_images_path
  end

  # 投稿データのストロングパラメータ
  private
  def  post_image_params
    # 複数の画像idになるため、配列[]で渡す
    params.require(:post_image).permit(:post_name, :caption, onsen_images_images: [])
  end
end