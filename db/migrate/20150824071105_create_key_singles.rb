class CreateKeySingles < ActiveRecord::Migration
  def change
    create_table :key_singles do |t|
      t.string :key

      t.timestamps null: false
    end
  end
end
