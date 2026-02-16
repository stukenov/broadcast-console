class CreateServers < ActiveRecord::Migration[7.1]
  def change
    create_table :servers do |t|
      t.string :name
      t.integer :cpu
      t.integer :total_memory
      t.timestamps
    end
  end
end
