class Post < ActiveRecord::Base
  #日付による絞り込み
  scope :get_by_date, ->(date) {
  where(date: date)
  }
  #場所による絞り込み
  scope :get_by_place, ->(place) {
  where(place: place)
  }
  #カテゴリによる絞り込み
  scope :get_by_category, ->(category) {
  where(category: category)
  }

  # 一つの投稿に対して多数のブックマークがつく
  has_many :bookmarks, :foreign_key => 'post_id'
  # 一つの投稿に対して多数のコメントがつく
  has_many :comments, :foreign_key => 'post_id'
  # 一つの投稿に対して多数の評価がつく
  has_many :evaluations, :foreign_key => 'post_id'
  # 投稿は一人のユーザーに従事する
  belongs_to :user, :foreign_key => 'user_id'

  # 投稿に対するバリデーション設定
  validates_presence_of :title
  validates_presence_of :image_name
  validates_presence_of :content
  validates_presence_of :date
  validates_presence_of :place
  validates_presence_of :category

end
