class UserController < ApplicationController



  def home
  end

  def show
    @user = User.find_by(id: params[:id])
    @post = Post.where(id: params[:id])
    @comment = Comment.where(id: params[:id])
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
    @user = User.find(params[:id])
    @post = Post.where(id: params[:id])
    @comment = Comment.where(id: params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.user_name = params[:user_name]
    redirect_to("/user/#{@user.id}")
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
      redirect_to ("/user/#{@user.id}")
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
      redirect_to('/home/top')
    end
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :email, :password)
  end

end
