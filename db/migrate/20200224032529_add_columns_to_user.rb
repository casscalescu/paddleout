class AddColumnsToUser < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :username, :string
  	add_column :users, :location, :string
  	add_column :users, :description, :text
  	add_column :users, :photo, :string
  end
end
