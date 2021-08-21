class LikesController < ApplicationController

  before_action :authenticate_user!

  def create
    @like = current_user.likes.build(like_params) #post_id(いいねを押した投稿のID)とuser_id(現在サインインしているユーザーのID)を取得
    @post = @like.post
    if @like.save
      respond_to :js #今回いいねを押したら、リアルタイムでビューを反映させるためにフォーマットをJS形式でレスポンスを返すようにしている
    end
  end

  def destroy
    @like = Like.find_by(id: params[:id])
    @post = @like.post
    if @like.destroy
      respond_to :js
    end
  end

  private
    def like_params
      params.permit(:post_id)
    end
end
