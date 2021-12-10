class PostImagesController < ApplicationController
  def new
    @post_image = PostImage.new
  end

  def create
    @post_image = PostImage.new(post_image_params)
    # deviseのヘルパーメゾット
    @post_image.user_id = current_user.id
    @is_images = 0
    # バリデーションの結果を表示
    # 画像が選択されていない時の条件分岐
    if params[:post_image][:onsen_images_images].size <= 1
      @post_image.valid?
      # 画像が選択されていなかった場合
      @is_images = 1
      render :new
    elsif @post_image.save
      # フラッシュメッセージの表示
      flash[:notice] = 'You have created post successfully.'
      redirect_to post_images_path
    else
      render :new
    end
  end

  def index
    # 一ページ分の決められた数のデータだけを、新しい順に取得するように変更
    @post_images = PostImage.page(params[:page]).reverse_order
  end

  def  show
    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @post_image = PostImage.find(params[:id])
    # 他人の投稿編集画面に推移できないようにする
    if @post_image.user == current_user
      render "edit"
    else
      redirect_to post_images_path
    end
  end

  def update
    @post_image = PostImage.find(params[:id])
    # バリデーションの結果を表示
    if @post_image.update(post_image_params)
      # フラッシュメッセージの表示
      flash[:notice] = 'You have updated post successfully.'
      redirect_to post_image_path(@post_image.id)
    else
      render :edit
    end

  end

  def destroy
    @post_image = PostImage.find(params[:id])
    @post_image.destroy
    redirect_to post_images_path
  end

  # 投稿データのストロングパラメータ
  private

  def post_image_params
    # 画像データを保持しているのはonsen_images
    # 複数の画像idになるため、配列[]で渡す
    params.require(:post_image).permit(:post_name, :caption, onsen_images_images: [])
  end
end
