require 'helper'

class TestDeliveryFormatsBuilder < Test::Unit::TestCase

  def setup
    file1 = File.dirname(__FILE__) + '/data/delivery_formats_1.xml'
    @formats1 = Netflix4Ruby::Builders::DeliveryFormatsBuilder.from_file file1
    file2 = File.dirname(__FILE__) + '/data/delivery_formats_2.xml'
    @formats2 = Netflix4Ruby::Builders::DeliveryFormatsBuilder.from_file file2
  end

  should 'create the expected number of formats' do
    assert_equal 2, @formats1.count
    assert_equal 3, @formats2.count
  end

  should 'create formats with availability dates' do
    assert_equal Time.at(1306911600), @formats1.first.available_from
    assert_equal Time.at(1370070000), @formats1.first.available_until
    assert_equal Time.at(1272956400), @formats1.last.available_from
    assert_nil @formats1.last.available_until
    assert_equal Time.at(1308985200), @formats2[0].available_from
    assert_equal Time.at(1356422400), @formats2[0].available_until
    assert_equal Time.at(1285657200), @formats2[1].available_from
    puts @formats2[1].available_until
    assert_equal Time.at(1285657200), @formats2[2].available_from
    puts @formats2[2].available_until
  end

  should 'create formats with labels' do
    assert_equal 'instant', @formats1.first.label
    assert_equal 'DVD', @formats1.last.label
    assert_equal 'Blu-ray', @formats2[1].label
  end

end
