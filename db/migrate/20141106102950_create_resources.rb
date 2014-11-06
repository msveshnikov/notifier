class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :url
      t.datetime :last_updated
      t.integer :hash_content

      t.timestamps
    end
  end
end
