require 'clockwork'

require './config/boot'
require './config/environment'

# App clock, gem 'clockwork'.
module Clockwork
  # Time for system tasks.
  SYS_TIME = '4:00'.freeze

  # rubocop:disable LineLength

  # every(5.minutes, 'reader.fetch.forums') { Reader::Fetcher::FetchForumsJob.perform_later }
  # every(15.minutes, 'reader.fetch.letters') { Reader::Fetcher::FetchLettersJob.perform_later }

  # every(1.minute, 'reader.send.letters', if: ->(time) { APP::SUPPORTED_MINUTES.include?(time.min) }) do
  #   Reader::Sender::SendLettersJob.perform_later(Time.zone.now.to_i)
  # end

  # every(1.day, 'reader.clean.feed_items', at: SYS_TIME) { Reader::CleanerJob.perform_later }
  # every(1.day, 'mailer.clean.messages', at: SYS_TIME) { Mailer::CleanerJob.perform_later }
end
