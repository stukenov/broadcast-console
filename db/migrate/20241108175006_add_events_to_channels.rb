class AddEventsToChannels < ActiveRecord::Migration[7.1]
  def change
    add_reference :channels, :events, null: true, foreign_key: true
  end
end
