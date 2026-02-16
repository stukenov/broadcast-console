class CreateSchedules < ActiveRecord::Migration[7.1]
  def change
    create_table :schedules do |t|
      t.string :name
      t.datetime :start_time
      t.datetime :end_time
      t.references :event, null: true, foreign_key: true
      t.timestamps
    end
  end
end
