class CreateRides < ActiveRecord::Migration[6.1]
  def change
    create_table :rides do |t|
      t.string     :destination_address, :departure_address
      t.text       :observation
      t.integer    :seats,       default: 0
      t.integer    :number_of_passagers,   default: 0
      t.date       :date,        null: false
      t.time       :time,        null: false
      t.boolean    :to_college,  null: false
      t.boolean    :full,        default: false, null: false
      t.boolean    :active,      default: true, null: false
      t.references :destination, null: false
      t.references :departure,   null: false
      t.references :driver,      null: false
      t.reference  :colleges,    foreing_key: true, null: false

      t.timestamps
    end
    add_foreign_key :rides, :users, column: :driver_id, primary_key: :id
    add_foreign_key :rides, :waypoints, column: :departure_id, primary_key: :id
    add_foreign_key :rides, :waypoints, column: :destination_id, primary_key: :id

  end
end
