class CreateAirports < ActiveRecord::Migration[8.0]
  def change
    create_table :airports do |t|
      t.string :code, null: false, index: { unique: true }
      t.string :city, null: false
      t.string :state
      t.string :country, null: false
      t.string :region, null: false

      t.timestamps
    end
  end
end
