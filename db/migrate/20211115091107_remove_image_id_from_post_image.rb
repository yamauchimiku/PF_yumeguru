class RemoveImageIdFromPostImage < ActiveRecord::Migration[5.2]
  def change
    remove_column :post_images, :image_id, :string
  end
end
