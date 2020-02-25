class RemovePhotoFromSurfboard < ActiveRecord::Migration[5.2]
  def change
  	remove_column :surfboards, :photo, :string
  	remove_column :users, :photo, :string
  end
end
