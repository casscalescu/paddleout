class CreateSurfboards < ActiveRecord::Migration[5.2]
  def change
    create_table :surfboards do |t|
      t.string :brand
      t.float :price
      t.string :photo
      t.string :type
      t.string :title
      t.string :price_duration
      t.text :description
      t.string :wave_type
      t.string :board_dimensions
      t.string :fin_type
      t.float :deposit
      t.string :skill_level
      t.string :wave_size
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
