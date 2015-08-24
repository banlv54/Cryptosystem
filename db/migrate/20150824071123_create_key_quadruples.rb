class CreateKeyQuadruples < ActiveRecord::Migration
  def change
    create_table :key_quadruples do |t|
      t.string :key

      t.timestamps null: false
    end
  end
end
