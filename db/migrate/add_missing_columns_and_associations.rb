class AddMissingColumnsAndAssociations < ActiveRecord::Migration[6.1]
  def change
    add_column :submissions, :product_id, :integer
    add_column :submissions, :directory_id, :integer
    add_column :submissions, :status, :integer, default: 0
    add_column :submissions, :error, :text

    add_index :submissions, :product_id
    add_index :submissions, :directory_id

    add_foreign_key :submissions, :products
    add_foreign_key :submissions, :directories
  end
end