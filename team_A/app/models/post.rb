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

end
