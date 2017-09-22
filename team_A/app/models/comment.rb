class Comment < ActiveRecord::Base
  # コメントは一つの投稿に従事する
  belongs_to :post, :foreign_key => 'post_id'
  # コメントは一人のユーザーに従事する
  belongs_to :user, :foreign_key => 'user_id'

  validates_presence_of :content
end
