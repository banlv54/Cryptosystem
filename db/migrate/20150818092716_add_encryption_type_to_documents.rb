class AddEncryptionTypeToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :encryption_type, :string
  end
end
