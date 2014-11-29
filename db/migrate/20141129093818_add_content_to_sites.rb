class AddContentToSites < ActiveRecord::Migration
  def change
    add_column :sites, :content, :text
  end
end
