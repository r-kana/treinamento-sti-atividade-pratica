class CreateRides < ActiveRecord::Migration[6.1]
  def change
    create_table :rides do |t|
      t.text       :observation
      t.string     :destination_neighborhood, :departure_neighborhood
      t.integer    :seats,               default: 0
      t.integer    :number_of_passagers, default: 0
      t.date       :date,                null: false
      t.time       :time,                null: false
      t.boolean    :to_college,          null: false
      t.boolean    :full,                default: false, null: false
      t.boolean    :active,              default: true,  null: false
      t.references :college,           foreing_key: true
      t.references :driver

      t.timestamps
    end
    add_foreign_key :rides, :users, column: :driver_id, primary_key: :id

  end
end
