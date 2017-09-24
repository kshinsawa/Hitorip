class User < ActiveRecord::Base
  has_many :posts
  has_many :comments, :foreign_key => 'user_id', :through => :posts
  has_many :bookmarks, :foreign_key => 'user_id'
  has_many :evaluations, :foreign_key => 'user_id', :through => :posts


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
