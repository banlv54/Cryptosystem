class AddTansoTansuatToKeyTables < ActiveRecord::Migration
  def change
    add_column :key_singles, :tanso, :integer
    add_column :key_singles, :tansuat, :decimal, precision: 12, scale: 10

    add_column :key_pairs, :tanso, :integer
    add_column :key_pairs, :tansuat, :decimal, precision: 12, scale: 10

    add_column :key_triples, :tanso, :integer
    add_column :key_triples, :tansuat, :decimal, precision: 12, scale: 10

    add_column :key_quadruples, :tanso, :integer
    add_column :key_quadruples, :tansuat, :decimal, precision: 12, scale: 10

    add_column :key_penta, :tanso, :integer
    add_column :key_penta, :tansuat, :decimal, precision: 12, scale: 10
  end
end
