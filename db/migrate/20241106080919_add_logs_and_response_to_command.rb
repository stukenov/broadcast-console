class AddLogsAndResponseToCommand < ActiveRecord::Migration[7.1]
  def change
    add_column :commands, :logs, :string
    add_column :commands, :response, :string
  end
end
