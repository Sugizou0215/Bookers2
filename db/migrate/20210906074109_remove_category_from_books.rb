class RemoveCategoryFromBooks < ActiveRecord::Migration[5.2]
  def change
    remove_column :books, :category, :integer
  end
end
