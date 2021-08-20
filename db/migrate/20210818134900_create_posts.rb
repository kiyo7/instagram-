class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :caption
      t.references :user, foreign_key: true,null: false #foreign_keyは外部キーとして使用する意味
      t.timestamps
    end
  end
end

# references型は参照先テーブル名の単数形+"_id"がカラム名として設定されるので、今回postsテーブルにはuser_idというカラムが追加される
