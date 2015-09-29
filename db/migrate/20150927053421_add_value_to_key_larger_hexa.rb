class AddValueToKeyLargerHexa < ActiveRecord::Migration
  def change
  	add_column :key_hexas, :value, :string

    add_column :key_hepta, :value, :string

    add_column :key_octa, :value, :string

    add_column :key_nonas, :value, :string

    add_column :key_decas, :value, :string
  end
end
