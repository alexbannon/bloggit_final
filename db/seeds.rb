# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Post.destroy_all
Comment.destroy_all

User.create(username: "alexbannon", password_digest: BCrypt::Password.create("alexbannon"), email: "alexbannon@gmail.com")
Post.create(title: "My Test Post", post_content: "The quick brown fox jumped over the lazy dog. The quick brown fox jumped over the lazy dog. The quick brown fox jumped over the lazy dog. The quick brown fox jumped over the lazy dog. The quick brown fox jumped over the lazy dog. The quick brown fox jumped over the lazy dog.", user_id: User.first.id)
Comment.create(comment_content: "This is the greatest post of all time", user_id: User.first.id, post_id: Post.first.id)
