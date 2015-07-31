class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :post_content
      t.datetime :created_at
      t.references :user, index: true, foreign_key: true
    end
  end
end
