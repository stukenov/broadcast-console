class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name
      t.references :videos, null: true, foreign_key: true
      t.datetime :start_time, precision: 0
      t.timestamps
    end
  end
end
