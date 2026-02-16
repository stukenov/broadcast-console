class AddLengthToVideos < ActiveRecord::Migration[7.1]
  def change
    add_column :videos, :length, :integer
  end
end
