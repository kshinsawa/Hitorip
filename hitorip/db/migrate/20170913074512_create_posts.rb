class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :image_name
      t.text :content
      t.date :date
      t.string :place
      t.string :category

      t.timestamps
    end
  end
end
