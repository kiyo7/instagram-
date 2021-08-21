class PostsController < ApplicationController

  # before_actionはアクションを実行する前にフィルターをかけるメソッド
  #今回の場合postsコントローラーのアクションを実行する前にこれを読み込む
  before_action :authenticate_user! #deviseのメソッド ユーザーがログインしているかを確認する。ログインしていない場合はログインページにリダイレクト

  before_action :set_post, only: %i(show destroy)

  def new
    @post = Post.new
    @post.photos.build
  end
  # buildもnewと同じインスタンス生成メソッド
  #railsの慣習でモデルを関連付けした時にbuildを使う(今回はPostモデルとPhotoモデルの関連付け)

def create
  @post = Post.new(post_params) #privateのpost_paramsメソッドを引数に呼んでいる

  if @post.photos.present? #投稿の写真の有無で分岐
    @post.save
    redirect_to root_path
    flash[:notice] = "投稿が保存されました"
  else
    redirect_to root_path
    flash[:alert] = "投稿に失敗しました"
  end 
end

def index
  @posts = Post.limit(10).includes(:photos, :user).order('created_at DESC')
  #limitは取り出すレコード数の上限を指定する（今回は10件
end

def show
end

def destroy
  if @post.user == current_user
    flash[:notice] = "投稿が削除されました" if @post.destroy #destroyはデータベースから削除するメソッド
  else
    flash[:alert] = "投稿の削除に失敗しました"
  end
  redirect_to root_path
end

private

  #privateメソッドを呼び出すときはレシーバを指定できない
  # 自分（self）以外のオブジェクトのメソッドを呼び出すには、レシーバを指定する必要がある
  #つまりprivateメソッドは外部から呼び出せない

  def post_params
    params.require(:post).permit(:caption, photos_attributes: [:image]).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find_by(id: params[:id]) #受け取ったHTTPリクエストからidを判別し、指定の投稿1つを@postに代入
  end

# paramsとは送られてきたリクエスト情報をひとまとめにしたもの

# requireで受け取る値のキーを設定

# permitで変更を加えられるキーを指定。今回の場合、captionキーとimageキーを指定。

# mergeメソッドは2つのハッシュを統合するメソッド。今回は誰が投稿したかという情報が必要なためuser_idの情報を統合している

end
