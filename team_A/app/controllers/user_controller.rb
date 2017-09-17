class UserController < ApplicationController

# 完成
  def home
  end

# 完成 
  def show
    @user = User.find_by(id: params[:id])
    @post = Post.where(id: params[:id])
    @comment = Comment.where(id: params[:id])
  end

# 完成
  def new
    @user = User.new
  end

# 完成
  def create
    @user = User.new(user_params)
    @user.save
    if @user.save
      session[:user_id] = @user.id
      redirect_to("/home/top")
    end
  end

  # idをuser_idに変える。ここのuser_idはUserモデルのカラム。
  # 投稿の編集とユーザ情報の更新は別のアクションで定義している。
  def edit
    @user = User.find(params[:id])
    @post = Post.where(id: params[:id])
    @comment = Comment.where(id: params[:id])
  end

# 完成
  def update
    @user = User.find(params[:id])
    if @user
      @user.user_name = params[:user_name]
      flash[:notice] = "編集しました"
      redirect_to("/user/#{@user.id}")
    end
  end

#　完成  
  def login_form
  end

# 完成  
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
  
# 完成
  def logout
    @user = User.find_by(id: session[:user_id])
    if @user
      session[:user_id] = nil
      flash[:notice] = "ログアウトしました"
      redirect_to('/home/top')
    end
  end

  def user_post
  end

  def alternation
      @post = Post.find(params[:id])
      @post.content = params[:content]
      redirect_to("/user/#{@user.id}")
  end

  private
  def user_params
    params.require(:user).permit(:user_name)
  end

  def posts_params
    params.require(:posts).permit(:title, :content, :data, :catrgory, :place)
  end

end
