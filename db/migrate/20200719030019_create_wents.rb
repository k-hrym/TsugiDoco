class CreateWents < ActiveRecord::Migration[5.2]
  def change
    create_table :wents do |t|
      t.references :user, foreign_key: true
      t.references :place, foreign_key: true

      t.timestamps

      t.index [:user_id, :place_id], unique: true
    end
  end
end
