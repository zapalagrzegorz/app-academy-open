class AddFavouriteToArtworkShare < ActiveRecord::Migration[5.2]
  def change
    add_column :artwork_shares, :favourite, :boolean, default: false
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
