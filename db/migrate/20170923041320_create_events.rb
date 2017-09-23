class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.references :location, foreign_key: true
      t.string :workout_type
      t.boolean :is_cancelled
      t.text :announcement
      t.integer :aqi
      t.integer :max_attendance
      t.datetime :date
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
