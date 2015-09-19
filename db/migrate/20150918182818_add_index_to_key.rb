class AddIndexToKey < ActiveRecord::Migration
  def change
    add_index :key_singles, :key

    add_index :key_pairs, :key

    add_index :key_triples, :key

    add_index :key_quadruples, :key

    add_index :key_penta, :key
  end
end
