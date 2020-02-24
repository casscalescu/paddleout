class AddLocationToSurfboard < ActiveRecord::Migration[5.2]
  def change
    add_column :surfboards, :location, :string
  end
end
