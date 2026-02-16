class AddLengthToCommands < ActiveRecord::Migration[7.1]
  def change
    add_column :commands, :length, :text
  end
end
