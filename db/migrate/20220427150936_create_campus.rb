class CreateCampus < ActiveRecord::Migration[6.1]
  def change
    create_table :campus do |t|

      t.timestamps
    end
  end
end
