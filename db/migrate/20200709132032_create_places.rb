class CreatePlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :places do |t|
      t.references :genre, foreign_key: true
      t.string :name
      t.text :explanation
      t.integer :postcode
      t.string :address
      t.string :access
      t.string :tel
      t.string :url
      t.string :hours
      t.string :price
      t.string :holiday
      t.boolean :is_closed,default: 0 #0が営業中,1が閉店

      t.timestamps
    end
  end
end
