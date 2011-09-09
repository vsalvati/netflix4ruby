require 'Nokogiri'

module Netflix4Ruby

  module Objects

    class CatalogTitle

      attr_accessor :title, :id, :id_url,
                    :box_art_small, :box_art_medium, :box_art_large

    end

  end

  module Builders

    class CatalogTitleBuilder

      def self.from_xml text
        from_xml_document Nokogiri::XML(text)
      end

      def self.from_xml_document document
        title = Netflix4Ruby::Objects::CatalogTitle.new

        title.id_url = document.xpath('.//id')[0].content
        title.id = title.id_url.split('/')[-1]
        title.title = document.xpath('.//title')[0][:regular]
        title.box_art_small = document.xpath('.//box_art')[0][:small]
        title.box_art_medium = document.xpath('.//box_art')[0][:medium]
        title.box_art_large = document.xpath('.//box_art')[0][:large]

        title
      end

      def self.from_file file
        from_xml_document Nokogiri::XML(open(file))
      end

    end

  end

end