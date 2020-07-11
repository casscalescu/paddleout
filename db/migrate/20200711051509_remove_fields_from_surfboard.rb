class RemoveFieldsFromSurfboard < ActiveRecord::Migration[5.2]
  def change
    rename_column :surfboards, :title, :name
    remove_column :surfboards, :wave_type
    remove_column :surfboards, :board_dimensions
    remove_column :surfboards, :fin_type
    remove_column :surfboards, :skill_level
    remove_column :surfboards, :wave_size
  end
end
