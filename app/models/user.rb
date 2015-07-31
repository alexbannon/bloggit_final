class User < ActiveRecord::Base
  # TODO: validations
  has_secure_password
  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
end
