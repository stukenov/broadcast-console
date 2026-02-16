class AddServerToChannels < ActiveRecord::Migration[7.1]
  def change
    add_reference :channels, :server, null: true, foreign_key: true
  end
end
