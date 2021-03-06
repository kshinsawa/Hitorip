class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_current_user

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

# エラー回避、投稿用
  def authenticate_user
    if @current_user == nil
      flash[:notice] = "ログインしてください"
      redirect_to ("/")
    end
  end

# 重複回避
  def user_registering_regulation
    @user = User.find_by(
      user_name: params[:user_name],
      email: params[:email]
    )
    if @user.present?
      flash[:notice] = "既に登録されています"
      redirect_to new_user_path
    end
  end

  def average_review
    @post = Post.find_by(id: params[:id])
    @sum = Evaluation.where(post_id: @post.id).sum(:review)
    @count = Evaluation.where(post_id: @post.id).count(:review)
    if @count == 0
      @review = "まだレビューはありません。"
    else
      @review = @sum / @count.to_f.round(1)
    end
  end

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/")
    end
  end
end
