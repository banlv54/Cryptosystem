class CreateKeyPenta < ActiveRecord::Migration
  def change
    create_table :key_penta do |t|
      t.string :key

      t.timestamps null: false
    end
  end
end
