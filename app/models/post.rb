class Post < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy #1つの投稿には複数の写真を持てる
  has_many :likes, -> { order(created_at: :desc) }, dependent: :destroy 
  #投稿が消されればいいねも削除されるように   #orderで降順に並べ替えて新しいいいね順で取得する

  accepts_nested_attributes_for :photos #投稿する際にPostモデルの子に値するPhotoモデルを通して、photosテーブルに写真を保存するs


  def liked_by(user)
    Like.find_by(user_id: user.id, post_id: id)  # user_idとpost_idが一致するlikeを検索する
  end
end
