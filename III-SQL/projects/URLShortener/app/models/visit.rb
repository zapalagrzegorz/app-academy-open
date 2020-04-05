# frozen_string_literal: true

# == Schema Information
#
# Table name: visits
#
#  id               :bigint           not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  shortened_url_id :bigint           not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_visits_on_shortened_url_id  (shortened_url_id)
#  index_visits_on_user_id           (user_id)
#
class Visit < ApplicationRecord
  # foreign
  belongs_to :visitor,
             primary_key: :id,
             foreign_key: :user_id,
             class_name: 'User'

  belongs_to :visited_url,
             primary_key: :id,
             foreign_key: :shortened_url_id,
             class_name: 'ShortenedUrl'

  #  Add a convenience factory method called Visit::record_visit!(user, shortened_url) that will create a Visit object recording a visit from a User to the given ShortenedUrl.

  def self.record_visit!(visitHsh = {})
    user = visitHsh[:user] || User.first

    shortened_url = visitHsh[:shortened_url] || ShortenedUrl.first

    Visit.create!(user_id: user.id, shortened_url_id: shortened_url.id)
  end
end
