class AddValueToKeyTables < ActiveRecord::Migration
  def change
    add_column :key_singles, :value, :string

    add_column :key_pairs, :value, :string

    add_column :key_triples, :value, :string

    add_column :key_quadruples, :value, :string

    add_column :key_penta, :value, :string
  end
end
