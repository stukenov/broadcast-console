class AddStoredInToVideos < ActiveRecord::Migration[7.1]
  def change
    add_reference :videos, :stored_in, null: true, foreign_key: { to_table: :servers }
  end
end
