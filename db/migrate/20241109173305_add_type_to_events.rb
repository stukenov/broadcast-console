class AddTypeToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :event_type, :integer, null: true, default: 0
  end
end
