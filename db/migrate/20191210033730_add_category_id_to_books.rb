class AddCategoryIdToBooks < ActiveRecord::Migration[6.0]
  def change
    add_reference :books, :category
  end
end
