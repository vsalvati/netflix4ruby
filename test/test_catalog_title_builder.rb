require 'helper'

class TestCatalogTitleBuilder < Test::Unit::TestCase

  def setup
    file = File.dirname(__FILE__) + '/catalog_titles.xml'
    @catalog_titles = Netflix4Ruby::Builders::CatalogTitleBuilder.from_file file
  end

  should 'create the expected number of titles' do
    assert_equal 25, @catalog_titles.count
  end

  should 'create a catalog title with basic attributes' do
    catalog_title = @catalog_titles[0]
    assert_equal 'http://api.netflix.com/catalog/titles/movies/60023642', catalog_title.id_url
    assert_equal '60023642', catalog_title.id
    assert_equal 'Spirited Away', catalog_title.title
  end

  should 'create a catalog title with box art urls' do
    catalog_title = @catalog_titles[0]
    assert_equal 'http://cdn-2.nflximg.com/en_us/boxshots/tiny/60023642.jpg', catalog_title.box_art_small
    assert_equal 'http://cdn-2.nflximg.com/en_us/boxshots/small/60023642.jpg', catalog_title.box_art_medium
    assert_equal 'http://cdn-2.nflximg.com/en_us/boxshots/large/60023642.jpg', catalog_title.box_art_large
  end

  should 'create catalog titles with an MPAA rating' do
    assert_equal 'PG', @catalog_titles[0].rating
    assert_equal 'NR', @catalog_titles[1].rating
    assert_equal 'PG', @catalog_titles[2].rating
    assert_equal 'PG-13', @catalog_titles[3].rating
  end

end
