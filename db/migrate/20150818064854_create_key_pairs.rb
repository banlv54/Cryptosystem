class CreateKeyPairs < ActiveRecord::Migration
  def change
    create_table :key_pairs do |t|
      t.string :key

      t.timestamps null: false
    end
  end
end
