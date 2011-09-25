module Netflix4Ruby

  module Objects

    class CatalogTitles

      attr_accessor :number_of_results, :start_index, :results_per_page, :titles

    end

    class CatalogTitle

      attr_accessor :title, :id, :id_url, :box_art, :mpaa_rating, :tv_rating, :average_rating,
                    :runtime, :release_year, :genres,
                    :formats_href

      attr_accessor :raw

      def initialize
        @box_art = {}
        @genres = []
      end

      def rating
        mpaa_rating || tv_rating
      end

    end

  end

  module Builders

    class CatalogTitlesBuilder

      def self.from_node node
        title = Netflix4Ruby::Objects::CatalogTitle.new

        title.id_url = node.xpath('.//id').first.content
        title.id = title.id_url.split('/').last
        title.title = node.xpath('.//title').first[:regular]

        art = node.xpath('.//box_art').first
        title.box_art[:small] = art[:small]
        title.box_art[:medium] = art[:medium]
        title.box_art[:large] = art[:large]

        title.mpaa_rating = mpaa_rating node
        title.tv_rating = tv_rating node

        title.average_rating = node.xpath('.//average_rating').first.content.to_f
        title.release_year = node.xpath('.//release_year').first.content
        title.runtime = node.xpath('.//runtime').first.content.to_i rescue ''

        title.genres = categories node, 'genres', 'label'

        title.formats_href = link node, 'catalog/titles/format_availability', 'href'

        title.raw = node.to_s

        title
      end

      def self.from_document document
        root = document.xpath('//catalog_titles')

        titles = Netflix4Ruby::Objects::CatalogTitles.new
        titles.number_of_results = root.xpath('.//number_of_results').first.content.to_i
        titles.start_index = root.xpath('.//start_index').first.content.to_i
        titles.results_per_page = root.xpath('.//results_per_page').first.content.to_i

        titles.titles = document.xpath('//catalog_title').collect { |node| from_node node }

        titles
      end

      def self.from_text text
        from_document Nokogiri::XML(text)
      end

      def self.from_file file
        from_document Nokogiri::XML(open(file))
      end

      private

      def self.categories node, scheme, attr
        scheme = "http://api.netflix.com/categories/#{scheme}"
        cat = node.xpath(".//category[@scheme=$scheme]", nil, :scheme => scheme)
        cat.collect { |c| c[attr] }
      end

      def self.mpaa_rating node
        cats = categories node, "mpaa_ratings", :label
        cats.first unless cats.empty?
      end

      def self.tv_rating node
        cats = categories node, "tv_ratings", :label
        cats.first unless cats.empty?
      end

      def self.link node, rel, attr
        rel = "http://schemas.netflix.com/#{rel}"
        link = node.xpath(".//link[@rel=$rel]", nil, :rel => rel)
        link.first[attr] unless link.empty?
      end

    end

  end

end
