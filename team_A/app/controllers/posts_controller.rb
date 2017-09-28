class PostsController < ApplicationController

  before_action :authenticate_user, {only: [:new, :create, :destroy]}
  before_action :average_review, {only: [:show]}

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
    # コンテンツ(フリーワード)で絞る
    if params[:content].present?
    @posts = @posts.get_by_content params[:content]
    end
  end

  def show
    if @current_user
      @post = Post.find_by(id: params[:id])
      @user = User.find_by(id: @post.user_id)
      @bookmark = Bookmark.find_by(user_id: @current_user.id)
      @comments = Comment.where(post_id: params[:id])
      @comment_user = User.joins("INNER JOIN comments ON comments.user_id = users.id").where("comments.post_id = ?", @post.id)
    else
      flash[:notice] = "ログインしてください"
      redirect_to("/posts/index")
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(
      title: params[:title],
      date: params[:date],
      place: params[:place],
      category: params[:category],
      content: params[:content],
      user_id: session[:user_id],
    )
    if params[:image]
      @post.image_name = "#{@post.title}.jpg"
      image = params[:image]
      File.binwrite("public/posts_images/#{@post.image_name}", image.read)
    end
    if @post.save
      flash[:notice] = "投稿が完了しました"
      redirect_to("/posts/index")
    else
      render("posts/new")
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.title = params[:title]
    @post.image_name = "#{@post.id}.jpg"
    @post.date = params[:date]
    @post.place = params[:place]
    @post.category = params[:category]
    @post.content = params[:content]
    @post.user_id = session[:user_id]
    if params[:image]
      @post.image_name = "#{@post.id}.jpg"
      image2 = params[:image]
      File.binwrite("public/posts_images/#{@post.image_name}", image2.read)
    end
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
      user_id: @current_user.id
    )
    @bookmark.save
    flash[:notice] = "ブックマークしました。"
    redirect_to posts_index_path
  end

  def evaluation
    @post = Post.find_by(id: params[:id])
    @evaluation = Evaluation.new(
      post_id: @post.id,
      user_id: @current_user.id,
      review: params[:review]
    )
    if @evaluation.save
      puts @evaluation.post_id
      puts @evaluation.user_id
      puts @evaluation.review
      flash[:notice] = "レビューしました。"
    end
    redirect_to("/posts/index")
  end
end
