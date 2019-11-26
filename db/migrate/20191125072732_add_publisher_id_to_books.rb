class AddPublisherIdToBooks < ActiveRecord::Migration[6.0]
  def change
    add_reference :books, :publisher
    # add_column :books, :publisher_id, :integer
    # add_index :books, :publisher_id
  end
end
