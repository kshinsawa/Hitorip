class CommentController < ApplicationController

  def create
    @post = Post.find_by(id: params[:id])
    @comment = Comment.new(
      post_id: @post.id,
      user_id: @current_user.id,
      content: params[:content]
    )
    @comment.save
    redirect_to("/posts/index")
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @comment.user_id = session[:user_id]
    @comment.destroy
    redirect_to(user_edit_path)
  end

end
