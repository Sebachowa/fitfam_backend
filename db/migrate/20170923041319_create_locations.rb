class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.string :address
      t.string :latitude
      t.string :longitude
      t.string :directions
      t.string :photo

      t.timestamps
    end
  end
end
