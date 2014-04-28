class DropEvents < ActiveRecord::Migration
  def change
    drop_table :events
    add_column :needs, :event_name, :string
  end
end
