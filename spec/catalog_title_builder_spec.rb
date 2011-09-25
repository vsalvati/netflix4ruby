require 'spec_helper'

describe Netflix4Ruby::Builders::CatalogTitleBuilder do

  before(:each) do
    file = File.dirname(__FILE__) + '/data/catalog_titles.xml'
    @catalog_titles = Netflix4Ruby::Builders::CatalogTitleBuilder.from_file file
  end

  it 'should create the expected number of titles' do
    @catalog_titles.should have(25).items
  end

  it 'should create a catalog title with basic attributes' do
    title = @catalog_titles.first
    title.id_url.should == 'http://api.netflix.com/catalog/titles/movies/60032294'
    title.id.should == '60032294'
    title.title.should == 'My Neighbor Totoro'
  end

  it 'should create a catalog title with box art urls' do
    title = @catalog_titles.first
    title.box_art_small.should == 'http://cdn-4.nflximg.com/en_us/boxshots/tiny/60032294.jpg'
    title.box_art_medium.should == 'http://cdn-4.nflximg.com/en_us/boxshots/small/60032294.jpg'
    title.box_art_large.should == 'http://cdn-4.nflximg.com/en_us/boxshots/large/60032294.jpg'
  end

  it 'should create catalog titles with an MPAA rating' do
    @catalog_titles[0].mpaa_rating.should == 'G'
    @catalog_titles[1].mpaa_rating.should == 'NR'
    @catalog_titles[5].mpaa_rating.should == 'PG'
    @catalog_titles[7].mpaa_rating.should == 'R'
  end

  it 'should create catalog titles with a TV rating' do
    @catalog_titles[22].tv_rating.should == 'TV-PG'
  end

  it 'should create catalog titles with some rating, TV or MPAA' do
    @catalog_titles[0].rating.should == 'G'
    @catalog_titles[1].rating.should == 'NR'
    @catalog_titles[5].rating.should == 'PG'
    @catalog_titles[7].rating.should == 'R'
    @catalog_titles[22].rating.should == 'TV-PG'
  end

  it 'should create titles with genre arrays' do
    @catalog_titles[0].genres.should include("Children & Family Movies", "Sci-Fi & Fantasy",
                                             "Movies for ages 2 to 4",  "Movies for ages 5 to 7",
                                             "Movies for ages 8 to 10", "Family Features",
                                             "Japanese Movies", "Fantasy", "Family Feature Animation")
    @catalog_titles[14].genres.should include("Comedies", "Romantic Movies", "Romantic Comedies")
  end

  it 'should create titles with average ratings' do
    @catalog_titles[2].average_rating.should == '3.3'
    @catalog_titles[6].average_rating.should == '3.6'
    @catalog_titles[14].average_rating.should == '3.2'
    @catalog_titles[21].average_rating.should == '3.2'
  end

  it 'should create titles with release years' do
    @catalog_titles[1].release_year.should == '2008'
    @catalog_titles[6].release_year.should == '2011'
    @catalog_titles[14].release_year.should == '2006'
    @catalog_titles[17].release_year.should == '1997'
    @catalog_titles[21].release_year.should == '2009'
  end

  it 'should create titles with runtimes' do
    @catalog_titles[4].runtime.should == '8520'
    @catalog_titles[7].runtime.should == '7320'
    @catalog_titles[15].runtime.should =='7200'
    @catalog_titles[19].runtime.should =='10560'
    @catalog_titles[24].runtime.should =='6060'
  end

  it 'should create titles with format availability hrefs' do
    @catalog_titles[7].formats_href.should == 'http://api.netflix.com/catalog/titles/movies/70065114/format_availability'
    @catalog_titles[15].formats_href.should == 'http://api.netflix.com/catalog/titles/movies/60020329/format_availability'
  end

end
