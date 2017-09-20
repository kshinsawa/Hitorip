class PostsController < ApplicationController

  # before_action :authenticate_user, {only: [:new, :create, :destroy]}

  def index
    # すべての投稿を取得する
    @posts = Post.all
    # 日付で絞る
    if params[:date].present?
    @posts = @posts.get_by_date params[:date]
    end
    # 場所で絞る
    if params[:place].present?
    @posts = @posts.get_by_place params[:place]
    end
    # カテゴリで絞る
    if params[:category].present?
    @posts = @posts.get_by_category params[:category]
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def new
  end

  def create
    @post = Post.new(
      title: params[:title],
      image_name: params[:image_name],
      date: params[:date],
      place: params[:place],
      category: params[:category],
      content: params[:content],
      user_id: session[:user_id]
    )
    if @post.save
      flash[:notice] = "投稿が完了しました"
      redirect_to("/posts/index")
    else
      render("posts/edit")
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.title = params[:title]
    @post.image_name= params[:image_name]
    @post.date = params[:date]
    @post.place = params[:place]
    @post.category = params[:category]
    @post.content = params[:content]
    @post.user_id = session[:user_id]
    if @post.save
      flash[:notice] = "編集が完了しました"
      redirect_to("/posts/index")
    else
      render("posts/edit")
    end
  end

  def destroy
    @user = User.find(session[:user_id])
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[notice] = "投稿を削除しました"
    redirect_to("/user/#{@user.id}")
  end

  def bookmark
    @post = Post.find_by(id: params[:id])
    @bookmark = Bookmark.new(
      post_id: @post.id,
      user_id: session[:user_id]
    )
    @bookmark.save
    redirect_to posts_index_path
  end

end
