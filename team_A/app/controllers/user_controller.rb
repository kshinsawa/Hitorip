class UserController < ApplicationController

  before_action :user_registering_regulation, {only: [:new, :create]}


  def home
  end

  def show
    @user = User.find_by(id: params[:id])
    @post = Post.where(user_id: @current_user.id)
    @comment = Comment.where(user_id: @current_user.id)
    # puts @comment.post_id
    # @commented_post = Post.joins("INNER JOIN comments ON comments.post_id = posts.id").where("comments.post_id = ?", @comment.post_id)
    @bookmark = Post.joins("INNER JOIN bookmarks ON bookmarks.post_id = posts.id").where("bookmarks.user_id = ?", @current_user.id)
    puts @user.image_name
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if params[:image]
      @user.image_name = "#{@user.user_name}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}",image.read)
    end
    if @user.save
      session[:user_id] = @user.id
      redirect_to("/home/top")
    else
      render (new_user_path)
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.update_attributes(user_params)
    if params[:image]
      @user.image_name = "#{@user.user_name}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}" ,image.read)
      puts @user.image_name
    end
    flash[:notice] = "編集しました"
    redirect_to user_path
  end

  def login_form
  end

  def login
    puts params
    @user = User.find_by(
      user_name: params[:user_name],
      password: params[:password]
    )
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to home_top_path
    else
      @user_name = params[:user_name]
      @password = params[:password]
      render("home/top")
    end
  end

  def logout
    @user = User.find_by(id: session[:user_id])
    if @user
      session[:user_id] = nil
      flash[:notice] = "ログアウトしました"
      redirect_to('/home/top')
    end
  end

  private
  def user_params
    params.permit(:user_name, :email, :password, :image_name)
  end

end
