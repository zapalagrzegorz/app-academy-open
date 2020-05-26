class ArtworkShare < ActiveRecord::Migration[5.2]
  def change
    create_table :artwork_shares do |t|
      t.bigint :artwork_id, null: false
      t.bigint :viewer_id, null: false
    end

    add_index :artwork_shares, :artwork_id
    add_index :artwork_shares, :viewer_id
    add_index :artwork_shares, [:viewer_id, :artwork_id], unique: true
    # Ensure that a user cannot have a single Artwork shared with them more than once
  end
end
