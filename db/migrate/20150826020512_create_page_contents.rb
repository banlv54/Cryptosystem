class CreatePageContents < ActiveRecord::Migration
  def change
    create_table :page_contents do |t|
      t.text :title
      t.text :content
      t.string :link, index: true

      t.timestamps null: false
    end
  end
end
