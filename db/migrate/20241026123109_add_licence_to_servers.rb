class AddLicenceToServers < ActiveRecord::Migration[7.1]
  def change
    add_reference :servers, :licence, null: true, foreign_key: true
    add_column :licences, :servers, :jsonb, default: []
  end
end
