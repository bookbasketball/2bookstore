class AddIsAvailableToCategory < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :is_available, :boolean
  end
end
