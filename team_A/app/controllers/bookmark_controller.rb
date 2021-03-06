class BookmarkController < ApplicationController

  def destroy
    @bookmark = Bookmark.find_by(user_id: @current_user.id)
    @post = Post.joins("INNER JOIN bookmarks ON bookmarks.post_id = posts.id").where("bookmarks.post_id = ?", @bookmark.post_id)
    @bookmark.destroy
    flash[:notice] = "ブックマークを取り消しました。"
    redirect_to("/user/#{@current_user.id}")
  end

end
