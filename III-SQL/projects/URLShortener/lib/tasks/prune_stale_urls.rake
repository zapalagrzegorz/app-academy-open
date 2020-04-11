# frozen_string_literal: true

namespace :shortened_url do
  desc 'Remove old URLs from Shortened_urls table a'
  task prune: :environment do
    puts 'Pruning old urls...'
    ShortenedUrl.prune(60)
  end
end

# namespace :prune do
#   task old_urls: :environment do
#     minutes = ENV['minutes'].to_i || 144
#     puts "Pruning old urls..."
#     ShortenedUrl.prune(minutes)
#   end
# end
