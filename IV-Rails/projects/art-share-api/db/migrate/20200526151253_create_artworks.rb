class CreateArtworks < ActiveRecord::Migration[5.2]
  def change
    create_table :artworks do |t|

      t.string :title, null: false
      t.string :image_url, null: false
      t.bigint :artist_id, null: false
      t.timestamps
    end

    # Ensure a single user cannot have two artworks with the same title. 
    # This means that the artist_id and title combination must be unique
    add_index :artworks, :artist_id
    add_index :artworks, :image_url, unique: true
    add_index :artworks, [:title, :artist_id], unique: true

  end
end
