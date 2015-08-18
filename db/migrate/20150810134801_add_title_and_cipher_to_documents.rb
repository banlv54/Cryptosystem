class AddTitleAndCipherToDocuments < ActiveRecord::Migration
  def change
    add_reference :documents, :cipher, type: :integer, index: true
    add_column :documents, :title, :string
  end
end
