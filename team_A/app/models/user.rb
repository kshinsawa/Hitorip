class User < ActiveRecord::Base

  has_many :comments
  has_many :posts
  has_many :bookmarks

  validates_presence_of :user_name
  validates_presence_of :email
  validates_presence_of :password

end
