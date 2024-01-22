class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.references :user, null: false #user_idが入っていないと保存できない
      t.string :title, null: false #validationがあってもこれは設定する
      t.text :content, null: false #validationがあってもこれは設定する
      t.timestamps
    end
  end
end
