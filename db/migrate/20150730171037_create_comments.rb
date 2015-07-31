class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :comment_content
      t.datetime :created_at
      t.references :user, index: true, foreign_key: true
      t.references :post, index: true, foreign_key: true
    end
  end
end
