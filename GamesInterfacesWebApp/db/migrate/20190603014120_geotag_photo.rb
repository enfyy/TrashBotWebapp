class GeotagPhoto < ActiveRecord::Migration[6.0]
  def change
    add_column :trash, :latitude, :decimal, precision: 9, scale: 6
    add_column :trash, :longitude, :decimal, precision: 9, scale: 6
    add_column :trash, :image_path, :string
  end
end
