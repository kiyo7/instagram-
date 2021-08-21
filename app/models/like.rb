class Like < ApplicationRecord

  belongs_to :user

  belongs_to :post

  validates :user_id, uniqueness: { scope: :post_id }

  # uniquenessは、オブジェクトが保存される直前に、属性の値が一意（unique）であり重複していないことを検証
  #ここではuser_idとpost_idの組み合わせが一つであることを示す（複数回いいねが出来ない）

end
