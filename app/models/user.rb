class User < ApplicationRecord

  has_many :likes

  has_many :comments

  #一人のユーザーは複数の投稿ができる
  has_many :posts, dependent: :destroy
  #has_manyで1対多の関係を表す(書くときは１の側に書く)反対に多の方にはbelongs_toが使われる

  #dependent: :destroyが付くとオブジェクトが削除されるときに、関連するものも消えるようになる
  # 例： ユーザーが削除されれば投稿内容も消える的なやつ

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  validates :name, presence: true, length: { maximum: 50 }

   def update_without_current_password(params, *options)
     params.delete(:current_password)
 
     if params[:password].blank? && params[:password_confirmation].blank?
       params.delete(:password)
       params.delete(:password_confirmation)
     end
 
     result = update(params, *options)
     clean_up_passwords
     result
   end
end
