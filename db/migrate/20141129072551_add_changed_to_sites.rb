class AddChangedToSites < ActiveRecord::Migration
  def change
    add_column :sites, :was_changed, :boolean
  end
end
