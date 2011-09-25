require 'spec_helper'

describe Netflix4Ruby::Builders::DeliveryFormatsBuilder do
  
  before(:each) do
    file1 = File.dirname(__FILE__) + '/data/delivery_formats_1.xml'
    @formats1 = Netflix4Ruby::Builders::DeliveryFormatsBuilder.from_file file1
    file2 = File.dirname(__FILE__) + '/data/delivery_formats_2.xml'
    @formats2 = Netflix4Ruby::Builders::DeliveryFormatsBuilder.from_file file2
  end

  it 'should create the expected number of formats' do
    @formats1.should have(2).formats
    @formats2.should have(3).formats
  end

  it 'should create formats with availability dates' do
    @formats1.first.available_from.should == Time.at(1306911600)
    @formats1.first.available_until.should == Time.at(1370070000)
    @formats1.last.available_from.should == Time.at(1272956400)
    @formats1.last.available_until.should be_nil
    @formats2[0].available_from.should == Time.at(1308985200)
    @formats2[0].available_until.should == Time.at(1356422400)
    @formats2[1].available_from.should == Time.at(1285657200)
    @formats2[1].available_until.should be_nil
    @formats2[2].available_from.should == Time.at(1285657200)
    @formats2[2].available_until.should be_nil
  end

  it 'should create formats with labels' do
    @formats1.first.label.should == 'instant'
    @formats1.last.label.should == 'DVD'
    @formats2[1].label.should == 'Blu-ray'
  end

end
