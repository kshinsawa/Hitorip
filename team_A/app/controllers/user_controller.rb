class UserController < ApplicationController

  before_action :user_registering_regulation, {only: [:new, :create]}


  def home
  end

  def show
    @user = User.find_by(id: params[:id])
    @post = Post.where(user_id: @current_user.id)
    @comment = Comment.where(user_id: @current_user.id)
    @bookmark = Post.joins("INNER JOIN bookmarks ON bookmarks.post_id = posts.id").where("bookmarks.user_id = ?", @current_user.id)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.save
    session[:user_id] = @user.id
    redirect_to("/home/top")
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user
      @user.user_name = params[:user_name]
      @user.email = params[:email]
      @user.password = params[:password]
      puts @user.user_name
      puts @user.email
      puts @user.password
      flash[:notice] = "編集しました"
      redirect_to user_path
    else
      flash[:notice] = "編集権限がありません"
      render('user/show')
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
      redirect_to home_top_path
    else
      @email = params[:email]
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
    params.permit(:user_name, :email, :password)
  end

end
