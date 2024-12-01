class AddMoreDetailsToTracks < ActiveRecord::Migration[7.0]
  def change
    add_column :tracks, :artist_name, :string
    add_column :tracks, :duration, :integer
  end
end
