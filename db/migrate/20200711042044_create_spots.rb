class CreateSpots < ActiveRecord::Migration[5.2]
  def change
    create_table :spots do |t|
      t.references :route, foreign_key: true
      t.references :place, foreign_key: true
      t.integer :order,null: false
      t.text :memo

      t.timestamps
    end
  end
end
