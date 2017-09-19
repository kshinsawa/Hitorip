class Post < ActiveRecord::Base

  has_many :comments
  has_many :evaluations
  belongs_to :user

  validates_presence_of :title
  validates_presence_of :image_name
  validates_presence_of :content
  validates_presence_of :date
  validates_presence_of :place
  validates_presence_of :catrgory

end
