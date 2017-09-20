class User < ActiveRecord::Base

  include ActiveModel::Model
  attr_accessor :user_name, :content 

  has_many :comments
  has_many :posts

  validates_presence_of :user_name
  validates_presence_of :email
  validates_presence_of :password
end
