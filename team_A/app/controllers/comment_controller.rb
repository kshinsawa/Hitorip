class CommentController < ApplicationController

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy
    redirect_to(user_edit_path)
end
