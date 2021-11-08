class CreatePostImages < ActiveRecord::Migration[5.2]
  def change
    create_table :post_images do |t|
      t.integer :user_id
      t.text :post_name
      t.text :caption
      t.string :image_id

      t.timestamps
    end
  end
end
