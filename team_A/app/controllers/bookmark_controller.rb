class BookmarkController < ApplicationController

  def destroy
    @bookmark = Bookmark.find_by(user_id: @current_user.id)
    @post = Post.joins("INNER JOIN bookmarks ON bookmarks.post_id = posts.id").where("bookmarks.post_id = ?", @bookmark.post_id)
    @bookmark.destroy
    redirect_to("/posts/#{@post.id}")
  end

end
