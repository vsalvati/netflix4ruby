require 'Nokogiri'

module Netflix4Ruby

  module Objects

    class QueueItem

      attr_accessor :title, :id_url,
                    :box_art_small, :box_art_medium, :box_art_large,
                    :queue_availability

    end

  end

  module Builders

    class QueueItemBuilder

      def self.from_node node
        title = Netflix4Ruby::Objects::QueueItem.new

        title.id_url = node.xpath('.//id')[0].content
        title.title = node.xpath('.//title')[0][:regular]
        title.box_art_small = node.xpath('.//box_art')[0][:small]
        title.box_art_medium = node.xpath('.//box_art')[0][:medium]
        title.box_art_large = node.xpath('.//box_art')[0][:large]

        title.queue_availability = case queue_availability node
                                     when 'available_now'; :available
                                     when 'saved'; :saved
                                   end

        title
      end

      def self.from_document document
        document.xpath('//queue_item').collect { |node| from_node node }
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

      def self.queue_availability node
        category(node, "http://api.netflix.com/categories/queue_availability")[:label]
      end

    end

  end

end