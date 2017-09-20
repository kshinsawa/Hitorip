class CommentController < ApplicationController

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @comment.user_id = session[:user_id]
    @comment.destroy
    redirect_to(user_edit_path)
end
