class UserController < ApplicationController

  before_action :user_registering_regulation, {only: [:new, :create]}


  def home
  end

  def show
    @user = User.find_by(id: params[:id])
    @post = Post.where(user_id: @current_user.id)
    @comment = Comment.where(user_id: params[:user_id])
  end


  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.save
    if @user.save
      session[:user_id] = @user.id
      redirect_to("/home/top")
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
    @post = Post.where(params[:user_id])
    @comment = Comment.where(params[:user_id])
  end

  def update
    @user = User.find(params[:id])
    if @user
      @user.user_name = params[:user_name]
      @user.content = params[:content]
      flash[:notice] = "編集しました"
      redirect_to user_path
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
    params.require(:user).permit(:user_name, :email, :password)
  end



end
