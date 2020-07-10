class CreatePlaceImages < ActiveRecord::Migration[5.2]
  def change
    create_table :place_images do |t|
      t.references :place, foreign_key: true,null: false
      t.references :user, foreign_key: true,null: false
      t.string :image_id,null: false

      t.timestamps
    end
  end
end
