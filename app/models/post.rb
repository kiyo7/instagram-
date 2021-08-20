class Post < ApplicationRecord

  belongs_to :user

  #1つの投稿には複数の写真を持てる
  has_many :photos, dependent: :destroy

  accepts_nested_attributes_for :photos #投稿する際にPostモデルの子に値するPhotoモデルを通して、photosテーブルに写真を保存するs

end
