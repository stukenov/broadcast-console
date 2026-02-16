class CreateLicences < ActiveRecord::Migration[7.1]
  def change
    create_table :licences do |t|
      t.string :key
      t.string :status
      t.timestamps
    end
  end
end
