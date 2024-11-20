class CreatePassengers < ActiveRecord::Migration[8.0]
  def change
    create_table :passengers do |t|
      t.belongs_to :booking, null: false, foreign_key: true
      t.string :name, null: false
      t.string :email, null: false

      t.timestamps
    end
  end
end
