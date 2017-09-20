class ChangePostsColumns < ActiveRecord::Migration
  def change
    remove_column :posts, :catrgory, :string
    add_column :posts, :category, :string
  end
end
