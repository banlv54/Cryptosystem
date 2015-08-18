class CreateCiphers < ActiveRecord::Migration
  def change
    create_table :ciphers do |t|
      t.text :content

      t.timestamps null: false
    end
  end
end
