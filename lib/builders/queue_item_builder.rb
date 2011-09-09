module Netflix4Ruby

  module Objects

    class QueueItem

      attr_accessor :title, :id_url,
                    :box_art_small, :box_art_medium, :box_art_large,
                    :queue_availability

      attr_accessor :raw

    end

  end

  module Builders

    class QueueItemBuilder

      def self.from_node node
        item = Netflix4Ruby::Objects::QueueItem.new

        item.id_url = node.xpath('.//id')[0].content
        item.title = node.xpath('.//title')[0][:regular]
        item.box_art_small = node.xpath('.//box_art')[0][:small]
        item.box_art_medium = node.xpath('.//box_art')[0][:medium]
        item.box_art_large = node.xpath('.//box_art')[0][:large]

        item.queue_availability = case queue_availability node
                                    when 'available now'; :available
                                    when 'available_now'; :available
                                    when 'saved'; :saved
                                  end

        item.raw = node.to_s

        item
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
