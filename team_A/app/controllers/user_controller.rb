class UserController < ApplicationController

  before_action :set_current_user

  def home
  end

  def top
    @user = User.find(params[:id])
    @post = Post.where(params[:id])
    @comment = Comment.where(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(
      user_name: params[:user_name],
      email: params[:email],
      password: params[:password]
    )
    session[:user_id] = @user.id
    @user.save
    redirect_to user_top_path(user_params[:user_id])
  end

  def edit
    @post = Post.where(id: params[:id])
    @comment = Comment.where(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.update_attributes(
      user_name: params[:user_name],
      email: params[:email],
      password: params[:password]
    )
    redirect_to('/user/:id')
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
      redirect_to('/user/:id')
    else
      render('user/login_form')
    end
  end

  def logout
    @user = User.find_by(id: session[:user_id])
    if @user
      session[:user_id] = nil
      redirect_to(user_top_path)
    end
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :email, :password)
  end

end
