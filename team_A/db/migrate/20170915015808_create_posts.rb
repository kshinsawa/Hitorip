class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :image_name
      t.text :content
      t.date :date
      t.string :place
      t.string :catrgory
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
