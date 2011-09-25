require 'spec_helper'

describe Netflix4Ruby::Builders::QueueItemBuilder do

  before(:each) do
    file = File.dirname(__FILE__) + '/data/instant_queue.xml'
    @queue_items = Netflix4Ruby::Builders::QueueItemBuilder.from_file file
  end

  it 'should create the expected number of items' do
    @queue_items.should have(3).items
  end

  it 'should create a queue item with basic attributes' do
    item = @queue_items.first
    item.id_url.should == 'http://api.netflix.com/users/UseRiDStRInG-/queues/instant/available/1/251454'
    item.title.should == 'An American in Paris'
  end

  it 'should create a queue item with box art urls' do
    item = @queue_items.first
    item.box_art_small.should == 'http://alien2.netflix.com/us/boxshots/tiny/251454.jpg'
    item.box_art_medium.should == 'http://alien2.netflix.com/us/boxshots/small/251454.jpg'
    item.box_art_large.should == 'http://alien2.netflix.com/us/boxshots/large/251454.jpg'
  end

  it 'should create items with queue availability' do
    @queue_items[0].queue_availability.should be :available
    @queue_items[1].queue_availability.should be :available
    @queue_items[2].queue_availability.should be :saved
  end

end
