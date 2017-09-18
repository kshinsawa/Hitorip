class PostsController < ApplicationController
  
  before_action :authenticate_user, {only: [:new, :create, :destroy]}
  
  def index
    # すべての投稿を取得する
    @posts = Post.all
    # 日付で絞る
    if params[:date].present?
    @posts = @posts.get_by_date params[:date]
    end
    # 場所で絞る
    if params[:place].present?
    @posts = @posts.get_by_gender params[:gender]
    end
    # カテゴリで絞る
    if params[:category].present?
    @posts = @posts.get_by_gender params[:category]
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def new
  end

  def create
    @post = Post.new(content: params[:content])
    @post.save
    redirect_to("/posts/index")
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    redirect_to("/posts/index")
  end

end
