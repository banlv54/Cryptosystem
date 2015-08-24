class CreateKeyTriples < ActiveRecord::Migration
  def change
    create_table :key_triples do |t|
      t.string :key

      t.timestamps null: false
    end
  end
end
