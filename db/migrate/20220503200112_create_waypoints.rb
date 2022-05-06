class CreateWaypoints < ActiveRecord::Migration[6.1]
  def change
    create_table :waypoints do |t|
      t.string :address, :city, :neighborhood, null: false
      t.integer :order,      default: 0, null: false
      t.boolean :is_college, null: false
      t.integer :kind,       null: false, limit: 1
      t.references :ride,    foreing_key: true

      t.timestamps
    end
  end
end
