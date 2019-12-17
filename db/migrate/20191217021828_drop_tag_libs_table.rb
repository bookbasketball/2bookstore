class DropTagLibsTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :tag_libs
  end
end
