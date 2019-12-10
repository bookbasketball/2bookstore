class ChangeIsAvailableToOnline < ActiveRecord::Migration[6.0]
  def change
    remove_column :categories, :is_available, :boolean
    add_column :categories, :online, :boolean, default: true
  end
end
