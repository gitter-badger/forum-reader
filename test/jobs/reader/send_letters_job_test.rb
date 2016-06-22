require 'test_helper'

module Reader
  class SendLettersJobTest < ActiveJob::TestCase
    attr_reader :letter, :letter_item, :test_time

    setup do
      @job = SendLettersJob.new

      @letter = letters(:dev)
      @letter_item = letter_items(:opennet)

      @test_time = Time.use_zone(letter.user.timezone) do
        Time.zone.parse("18-6-2016 #{letter.hour}:#{letter.minute}")
      end
    end

    test 'perform' do
      assert_enqueued_jobs(2) { job.class.perform_now(test_time.to_s) }
      assert_no_enqueued_jobs { job.class.perform_now(Time.zone.now.to_s) }
    end

    test 'find_letters_for_send' do
      stub(job).time { Time.zone.now }
      assert_empty job.send(:find_letters_for_send)

      stub(job).time { test_time }
      assert_not_empty job.send(:find_letters_for_send)
    end

    test 'news_in => true' do
      stub(job).time { Time.zone.now }
      letter_item.update!(last_post_at: 1_000_000.days.ago)

      news = job.send(:news_in, letter)
      assert_not_empty news
    end

    test 'news_in => false' do
      FeedItem.delete_all
      stub(job).time { Time.zone.now }
      assert_empty job.send(:news_in, letter)
    end

    test 'news_in_the => true' do
      stub(job).time { Time.zone.now }
      letter_item.update!(last_post_at: 1_000_000.days.ago)

      news = job.send(:news_in_the, letter_item)
      assert_not_empty news
    end

    test 'news_in_the => false' do
      FeedItem.delete_all
      stub(job).time { Time.zone.now }
      assert_empty job.send(:news_in_the, letter_item)
    end

    test 'update_last_post_at' do
      stub(job).time { 1.year.ago }

      pre1 = letter.last_post_at
      pre2 = letter.letter_items.first.last_post_at

      job.send(:update_last_post_at, letter)

      cur1 = letter.reload.last_post_at
      cur2 = letter.letter_items.first.reload.last_post_at

      assert_not_equal cur1, pre1, 'changed for letter'
      assert_not_equal cur2, pre2, 'changed for letter_item'
    end

    test 'send_time? => true' do
      stub(job).time { test_time }
      travel_to(test_time) { assert job.send(:send_time?, letter) }
    end

    test 'send_time? => false' do
      stub(job).time { Time.zone.now }
      travel_to(Time.zone.now) { assert_not job.send(:send_time?, letter) }
    end
  end
end
