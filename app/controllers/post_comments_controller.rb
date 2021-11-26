class PostCommentsController < ApplicationController
  def create
    post_image = PostImage.find(params[:post_image_id])
    # 省略
    comment = current_user.post_comments.new(post_comment_params)
    # 同じ写真
    comment.post_image_id = post_image.id
    comment.save
    # 同じリダイレクト先
    redirect_to request.referer
  end

  def destroy
    # 検索でヒットしたレコードの初めの一件だけを返す
    PostComment.find_by(id: params[:id]).destroy
    redirect_to request.referer
  end

  # コメントデータのストロングパラメータ
  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
