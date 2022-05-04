class CreateRides < ActiveRecord::Migration[6.1]
  def change
    create_table :rides do |t|
      t.string :destination_address, :departure_address
      t.integer :seats, default: 0
      t.datetime :date_time, null: false
      t.text :observation
      t.reference :campuses, foreing_key: true, null: false
      t.boolean :to_campus, null: false
      t.references :destination, null: false
      t.references :departure, null: false
      t.references :driver, null: false
      t.boolean :active, default: true, null: false

      t.timestamps
    end
    add_foreign_key :rides, :users, column: :driver_id, primary_key: :id
    add_foreign_key :rides, :waypoints, column: :departure_id, primary_key: :id
    add_foreign_key :rides, :waypoints, column: :destina_id, primary_key: :id

  end
end
