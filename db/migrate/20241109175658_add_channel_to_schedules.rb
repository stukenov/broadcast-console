class AddChannelToSchedules < ActiveRecord::Migration[7.1]
  def change
    add_reference :schedules, :channel, null: true, foreign_key: true
  end
end
