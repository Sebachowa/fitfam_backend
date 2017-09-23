class AddCheckedInToBooking < ActiveRecord::Migration[5.1]
  def change
    add_column :bookings, :checked_in, :boolean, default: false
  end
end
