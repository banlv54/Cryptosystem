class CreateCreateSixToTenModels < ActiveRecord::Migration
  def change
    create_table :key_hexas do |t|
      t.string :key, index: true
      t.integer :tanso
      t.decimal  :tansuat,  precision: 12, scale: 10
      t.timestamps null: false
    end

    create_table :key_hepta do |t|
      t.string :key, index: true
      t.integer :tanso
      t.decimal  :tansuat,  precision: 12, scale: 10
      t.timestamps null: false
    end

    create_table :key_octa do |t|
      t.string :key, index: true
      t.integer :tanso
      t.decimal  :tansuat,  precision: 12, scale: 10
      t.timestamps null: false
    end

    create_table :key_nonas do |t|
      t.string :key, index: true
      t.integer :tanso
      t.decimal  :tansuat,  precision: 12, scale: 10
      t.timestamps null: false
    end

    create_table :key_decas do |t|
      t.string :key, index: true
      t.integer :tanso
      t.decimal  :tansuat,  precision: 12, scale: 10
      t.timestamps null: false
    end
  end
end
