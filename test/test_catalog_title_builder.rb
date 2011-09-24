require 'helper'

class TestCatalogTitleBuilder < Test::Unit::TestCase

  def setup
    file = File.dirname(__FILE__) + '/data/catalog_titles.xml'
    @catalog_titles = Netflix4Ruby::Builders::CatalogTitleBuilder.from_file file
  end

  should 'create the expected number of titles' do
    assert_equal 25, @catalog_titles.count
  end

  should 'create a catalog title with basic attributes' do
    catalog_title = @catalog_titles[0]
    assert_equal 'http://api.netflix.com/catalog/titles/movies/60032294', catalog_title.id_url
    assert_equal '60032294', catalog_title.id
    assert_equal 'My Neighbor Totoro', catalog_title.title
  end

  should 'create a catalog title with box art urls' do
    catalog_title = @catalog_titles[0]
    assert_equal 'http://cdn-4.nflximg.com/en_us/boxshots/tiny/60032294.jpg', catalog_title.box_art_small
    assert_equal 'http://cdn-4.nflximg.com/en_us/boxshots/small/60032294.jpg', catalog_title.box_art_medium
    assert_equal 'http://cdn-4.nflximg.com/en_us/boxshots/large/60032294.jpg', catalog_title.box_art_large
  end

  should 'create catalog titles with an MPAA rating' do
    assert_equal 'G', @catalog_titles[0].mpaa_rating
    assert_equal 'NR', @catalog_titles[1].mpaa_rating
    assert_equal 'PG', @catalog_titles[5].mpaa_rating
    assert_equal 'R', @catalog_titles[7].mpaa_rating
  end

  should 'create catalog titles with a TV rating' do
    assert_equal 'TV-PG', @catalog_titles[22].tv_rating
  end

  should 'create catalog titles with some rating, TV or MPAA' do
    assert_equal 'G', @catalog_titles[0].rating
    assert_equal 'NR', @catalog_titles[1].rating
    assert_equal 'PG', @catalog_titles[5].rating
    assert_equal 'R', @catalog_titles[7].rating
    assert_equal 'TV-PG', @catalog_titles[22].rating
  end

  should 'create titles with genre arrays' do
    assert_equal ["Children & Family Movies", "Sci-Fi & Fantasy", "Movies for ages 2 to 4",
                  "Movies for ages 5 to 7", "Movies for ages 8 to 10", "Family Features",
                  "Japanese Movies", "Fantasy", "Family Feature Animation"], @catalog_titles[0].genres
    assert_equal ["Comedies", "Romantic Movies", "Romantic Comedies"], @catalog_titles[14].genres
  end

  should 'create titles with average ratings' do
    assert_equal '3.3', @catalog_titles[2].average_rating
    assert_equal '3.6', @catalog_titles[6].average_rating
    assert_equal '3.2', @catalog_titles[14].average_rating
    assert_equal '3.2', @catalog_titles[21].average_rating
  end

  should 'create titles with release years' do
    assert_equal '2008', @catalog_titles[1].release_year
    assert_equal '2011', @catalog_titles[6].release_year
    assert_equal '2006', @catalog_titles[14].release_year
    assert_equal '1997', @catalog_titles[17].release_year
    assert_equal '2009', @catalog_titles[21].release_year
  end

  should 'create titles with runtimes' do
    assert_equal '8520', @catalog_titles[4].runtime
    assert_equal '7320', @catalog_titles[7].runtime
    assert_equal '7200', @catalog_titles[15].runtime
    assert_equal '10560', @catalog_titles[19].runtime
    assert_equal '6060', @catalog_titles[24].runtime
  end

  should 'create titles with format availability hrefs' do
    assert_equal 'http://api.netflix.com/catalog/titles/movies/70065114/format_availability', @catalog_titles[7].formats_href
    assert_equal 'http://api.netflix.com/catalog/titles/movies/60020329/format_availability', @catalog_titles[15].formats_href
  end

end
