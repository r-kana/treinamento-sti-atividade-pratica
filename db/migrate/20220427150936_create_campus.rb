class CreateCampus < ActiveRecord::Migration[6.1]
  def change
    create_table :campus do |t|
      t.string :name
      t.string :phone_number
      t.string :address
      t.string :cep 
      t.string :city
      t.string :neighborhood

      t.timestamps
    end
  end
end
