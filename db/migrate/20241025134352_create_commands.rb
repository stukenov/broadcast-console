class CreateCommands < ActiveRecord::Migration[7.1]
  def change
    create_table :commands do |t|
      t.references :server, null: false, foreign_key: true
      t.string :target
      t.string :command
      t.string :status
      t.timestamps
    end
  end
end
