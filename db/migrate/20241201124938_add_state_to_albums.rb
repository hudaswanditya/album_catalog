class AddStateToAlbums < ActiveRecord::Migration[7.0]
  def change
    add_column :albums, :state, :integer, default: 0, null: false
  end
end
