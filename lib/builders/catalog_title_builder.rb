require 'Nokogiri'

module Netflix4Ruby

  module Objects

    class CatalogTitle

      attr_accessor :title, :id, :id_url,
                    :box_art_small, :box_art_medium, :box_art_large,
                    :rating

    end

  end

  module Builders

    class CatalogTitleBuilder

      def self.from_node node
        title = Netflix4Ruby::Objects::CatalogTitle.new

        title.id_url = node.xpath('.//id')[0].content
        title.id = title.id_url.split('/')[-1]
        title.title = node.xpath('.//title')[0][:regular]
        title.box_art_small = node.xpath('.//box_art')[0][:small]
        title.box_art_medium = node.xpath('.//box_art')[0][:medium]
        title.box_art_large = node.xpath('.//box_art')[0][:large]

        title.rating = rating node

        title
      end

      def self.from_document document
        document.xpath('//catalog_title').collect { |node| from_node node }
      end

      def self.from_text text
        from_document Nokogiri::XML(text)
      end

      def self.from_file file
        from_document Nokogiri::XML(open(file))
      end

      private

      def self.category node, scheme
        node.xpath(".//category[@scheme=$scheme]", nil, :scheme => scheme)[0]
      end

      def self.rating node
        category(node, "http://api.netflix.com/categories/mpaa_ratings")[:label]
      end

    end

  end

end