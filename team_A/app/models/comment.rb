class Comment < ActiveRecord::Base
  # コメントは一つの投稿に従事する
  belongs_to :posts
  # コメントは一人のユーザーに従事する
  belongs_to :users

end
