require 'spec_helper'

describe Netflix4Ruby::Builders::CatalogTitlesBuilder do

  before(:each) do
    file = File.dirname(__FILE__) + '/data/catalog_titles.xml'
    @catalog_titles = Netflix4Ruby::Builders::CatalogTitlesBuilder.from_file file
    @titles = @catalog_titles.titles
  end

  it 'should create the expected number of titles' do
    @catalog_titles.should have(25).titles
  end

  it 'should have a number of results' do
    @catalog_titles.number_of_results.should == 1875
  end

  it 'should have a starting index' do
    @catalog_titles.start_index.should == 0
  end

  it 'should have a number of results per page' do
    @catalog_titles.results_per_page.should == 25
  end

  it 'should create a catalog title with basic attributes' do
    title = @titles.first
    title.id_url.should == 'http://api.netflix.com/catalog/titles/movies/60032294'
    title.id.should == '60032294'
    title.title.should == 'My Neighbor Totoro'
  end

  it 'should create a catalog title with box art urls' do
    title = @titles.first
    title.box_art_small.should == 'http://cdn-4.nflximg.com/en_us/boxshots/tiny/60032294.jpg'
    title.box_art_medium.should == 'http://cdn-4.nflximg.com/en_us/boxshots/small/60032294.jpg'
    title.box_art_large.should == 'http://cdn-4.nflximg.com/en_us/boxshots/large/60032294.jpg'
  end

  it 'should create catalog titles with an MPAA rating' do
    @titles[0].mpaa_rating.should == 'G'
    @titles[1].mpaa_rating.should == 'NR'
    @titles[5].mpaa_rating.should == 'PG'
    @titles[7].mpaa_rating.should == 'R'
  end

  it 'should create catalog titles with a TV rating' do
    @titles[22].tv_rating.should == 'TV-PG'
  end

  it 'should create catalog titles with some rating, TV or MPAA' do
    @titles[0].rating.should == 'G'
    @titles[1].rating.should == 'NR'
    @titles[5].rating.should == 'PG'
    @titles[7].rating.should == 'R'
    @titles[22].rating.should == 'TV-PG'
  end

  it 'should create titles with genre arrays' do
    @titles[0].genres.should include("Children & Family Movies", "Sci-Fi & Fantasy",
                                             "Movies for ages 2 to 4",  "Movies for ages 5 to 7",
                                             "Movies for ages 8 to 10", "Family Features",
                                             "Japanese Movies", "Fantasy", "Family Feature Animation")
    @titles[14].genres.should include("Comedies", "Romantic Movies", "Romantic Comedies")
  end

  it 'should create titles with average ratings' do
    @titles[2].average_rating.should == 3.3
    @titles[6].average_rating.should == 3.6
    @titles[14].average_rating.should == 3.2
    @titles[21].average_rating.should == 3.2
  end

  it 'should create titles with release years' do
    @titles[1].release_year.should == '2008'
    @titles[6].release_year.should == '2011'
    @titles[14].release_year.should == '2006'
    @titles[17].release_year.should == '1997'
    @titles[21].release_year.should == '2009'
  end

  it 'should create titles with runtimes' do
    @titles[4].runtime.should == 8520
    @titles[7].runtime.should == 7320
    @titles[15].runtime.should == 7200
    @titles[19].runtime.should == 10560
    @titles[24].runtime.should == 6060
  end

  it 'should create titles with format availability hrefs' do
    @titles[7].formats_href.should == 'http://api.netflix.com/catalog/titles/movies/70065114/format_availability'
    @titles[15].formats_href.should == 'http://api.netflix.com/catalog/titles/movies/60020329/format_availability'
  end

end
