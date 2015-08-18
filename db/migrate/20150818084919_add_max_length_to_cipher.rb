class AddMaxLengthToCipher < ActiveRecord::Migration
  def change
    add_column :ciphers, :max_length, :integer
  end
end
