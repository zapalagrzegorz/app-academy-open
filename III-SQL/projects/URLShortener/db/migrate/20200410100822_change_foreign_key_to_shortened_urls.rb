# frozen_string_literal: true

require_relative '20200402195523_add_user_ref_to_shortened_urls.rb'

class ChangeForeignKeyToShortenedUrls < ActiveRecord::Migration[5.2]
  def change
    revert AddUserRefToShortenedUrls

    add_column :shortened_urls, :submitter_id, :integer
    change_column_null :shortened_urls, :submitter_id, false

    add_index :shortened_urls, :submitter_id
  end
end
