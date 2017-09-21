class User < ActiveRecord::Base

  has_many :posts
  has_many :comments, :through => :posts
  has_many :bookmarks, :foreign_key => 'user_id'

  validates_presence_of :user_name
  validates_presence_of :email
  validates_presence_of :password

end
