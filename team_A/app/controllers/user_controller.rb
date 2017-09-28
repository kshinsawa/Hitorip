class UserController < ApplicationController

  before_action :user_registering_regulation, {only: [:new, :create]}


  def home
  end

  def show
    @user = User.find_by(id: params[:id])
    @post = Post.where(user_id: @user.id)
    @comment = Comment.where(user_id: @user.id)
    @comment_post = Post.joins("INNER JOIN comments ON posts.id = comments.post_id").where("comments.user_id = ?", @user.id)
    @bookmark = Post.joins("INNER JOIN bookmarks ON bookmarks.post_id = posts.id").where("bookmarks.user_id = ?", @user.id)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if params[:image]
      @user.image_name = "#{@user.user_name}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    else
      @user.image_name ="default_image.jpg"
    end
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Hitripへようこそ！"
      redirect_to("/")
    else
      render (new_user_path)
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.user_name = params[:user_name]
    @user.image_name = "#{@user.id}.jpg"
    @user.email = params[:email]
    @user.password = params[:password]
    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image2 = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}", image2.read)
    end
    if @user.save
      flash[:notice] = "編集しました"
      redirect_to user_path
    else
      render (edit_user_path)
    end
  end

  def login_form
  end

  def login
    puts params
    @user = User.find_by(
      email: params[:email],
      password: params[:password]
    )
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to("/")
    else
      @email = params[:email]
      @password = params[:password]
      flash[:notice] = "メールアドレスもしくはパスワードが正しくありません"
      render("user/login_form")
    end
  end

  def logout
    @user = User.find_by(id: session[:user_id])
    if @user
      session[:user_id] = nil
      flash[:notice] = "ログアウトしました"
      redirect_to('/')
    end
  end

  private
  def user_params
    params.permit(:user_name, :email, :password, :image_name)
  end

end
