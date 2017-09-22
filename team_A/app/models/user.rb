class User < ActiveRecord::Base
  has_many :posts
  has_many :comments, :foreign_key => 'user_id'
  has_many :bookmarks, :foreign_key => 'user_id'
  has_many :evaluations, :foreign_key => 'user_id'

  # validates_presence_of :user_name
  # validates_presence_of :email
  # validates_presence_of :password

  validate :add_error_user

  def add_error_user
    if user_name.blank?
      errors[:base] << "ユーザ名を入力して下さい"
    end
    if email.blank?
      errors[:base] << "メールアドレスを入力して下さい"
    end
    if password.blank?
      errors[:base] << "パスワードを入力して下さい"
    end
  end


end
