require 'helper'

class TestQueueItemBuilder < Test::Unit::TestCase

  file = File.dirname(__FILE__) + '/instant_queue.xml'

  should 'create the expected number of items' do
    queue_items = Netflix4Ruby::Builders::QueueItemBuilder.from_file file
    assert_equal 3, queue_items.count
  end

  should 'create a queue item with basic attributes' do
    queue_items = Netflix4Ruby::Builders::QueueItemBuilder.from_file file

    queue_item = queue_items[0]
    assert_equal 'http://api.netflix.com/users/T1DonaZPk00Jl39mXvKMpOsJ344BJtLQAh4SyvxWAV4Tk-/queues/instant/available/1/251454', queue_item.id_url
    assert_equal 'An American in Paris', queue_item.title
  end

  should 'create a queue item with box art urls' do
    queue_items = Netflix4Ruby::Builders::QueueItemBuilder.from_file file

    queue_item = queue_items[0]
    assert_equal 'http://alien2.netflix.com/us/boxshots/tiny/251454.jpg', queue_item.box_art_small
    assert_equal 'http://alien2.netflix.com/us/boxshots/small/251454.jpg', queue_item.box_art_medium
    assert_equal 'http://alien2.netflix.com/us/boxshots/large/251454.jpg', queue_item.box_art_large
  end

end
