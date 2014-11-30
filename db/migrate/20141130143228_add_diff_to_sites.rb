class AddDiffToSites < ActiveRecord::Migration
  def change
    add_column :sites, :diff, :text
  end
end
