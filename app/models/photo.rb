class Photo < ApplicationRecord
  #写真は1つの投稿に関係する
  belongs_to :post

  #presence: trueは値が空でないかを確認する
  validates :image, presence: true

  mount_uploader :image, ImageUploader
end
