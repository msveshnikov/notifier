class AddCategoryToSite < ActiveRecord::Migration
  def change
    add_reference :sites, :category, index: true
  end
end
