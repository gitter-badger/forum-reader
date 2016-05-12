require_relative '../../config/initializers/active_job'
require_relative '../helpers.rb'
require 'eventmachine'

module Reader
  # Fetch Forum -s and Letter -s periodically from remote Url -s.
  #
  # Parts:
  #
  # 1. FetchForumsJob
  # 2. FetchLettersJob
  # 3. FetchFeedJob
  # 4. FetchedFeedJob
  #
  class Fetcher
    QUEUE_NAME = 'reader.fetcher'.to_sym

    # Wait for FetchFeedJob -s and process them.
    def self.run
      EventMachine.run do
        tube = Helpers.get_tube(QUEUE_NAME)
        while tube.peek(:ready)
          job = tube.reserve
          process(job)
          job.delete
        end
      end
    end

    # Only :forum or :letter_item.
    def self.raise_if_bad(resource_type)
      raise 'Bad resource_type' if resource_type != :forum &&
                                   resource_type != :letter_item
    end

    class << self
      protected

      # Make request to Url and invoke FetchedFeedJob with response.
      def process(job)
        json = JSON.parse(job)

        url = json[0]
        resource_type = json[1]

        raise_if_bad(resource_type)

        http = EventMachine::HttpRequest.new(url).get
        http.callback { enqueue_ffj(url, http.response, resource_type) }
      end

      private

      def enqueue_ffj(url, response, resource_type)
        FetchedFeedJob.perform_later(url, response, resource_type) unless
          response.blank?
      end
    end
  end
end

## Run in console
Reader::Fetcher.run unless defined?(Rails)
