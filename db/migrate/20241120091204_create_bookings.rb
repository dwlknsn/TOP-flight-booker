class CreateBookings < ActiveRecord::Migration[8.0]
  def change
    create_table :bookings do |t|
      t.belongs_to :flight, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
