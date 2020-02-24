class ChangeColumnNameInSurfboard < ActiveRecord::Migration[5.2]
  def change
    rename_column :surfboards, :type, :category
  end
end
