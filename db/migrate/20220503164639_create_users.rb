class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :iduff
      t.boolean :admin, :active

      t.timestamps
    end
  end
end
