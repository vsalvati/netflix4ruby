require 'spec_helper'

describe Netflix4Ruby::Builders::QueueBuilder do

  before(:each) do
    file = File.dirname(__FILE__) + '/data/instant_queue.xml'
    @queue = Netflix4Ruby::Builders::QueueBuilder.from_file file
    @items = @queue.items
  end

  it 'should create the expected number of items' do
    @queue.should have(3).items
  end

  it 'should have a number of results' do
    @queue.number_of_results.should == 220
  end

  it 'should have a starting index' do
    @queue.start_index.should == 0
  end

  it 'should have a number of results per page' do
    @queue.results_per_page.should == 3
  end

  it 'should create a queue item with basic attributes' do
    item = @items.first
    item.id_url.should == 'http://api.netflix.com/users/UseRiDStRInG-/queues/instant/available/1/251454'
    item.title.should == 'An American in Paris'
  end

  it 'should create a queue item with box art urls' do
    item = @items.first
    item.box_art[:small].should == 'http://alien2.netflix.com/us/boxshots/tiny/251454.jpg'
    item.box_art[:medium].should == 'http://alien2.netflix.com/us/boxshots/small/251454.jpg'
    item.box_art[:large].should == 'http://alien2.netflix.com/us/boxshots/large/251454.jpg'
  end

  it 'should create items with queue availability' do
    @items[0].queue_availability.should be :available
    @items[1].queue_availability.should be :available
    @items[2].queue_availability.should be :saved
  end

end
