class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
      t.integer :review
      t.integer :user_id
      t.integer :post_id

      t.timestamps null: false
    end
  end
end
