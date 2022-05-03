class CreateColleges < ActiveRecord::Migration[6.1]
  def change
    create_table :colleges do |t|
      t.string :name, :phone_number, :address, :city, :neighborhood
      t.string :cep, limit: 9
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
