module Netflix4Ruby

  module Objects

    class Queue

      attr_accessor :number_of_results, :start_index, :results_per_page, :items

    end

    class QueueItem

      attr_accessor :title, :id, :id_url, :box_art,
                    :queue_availability

      attr_accessor :raw

      def initialize
        @box_art = {}
      end

    end

  end

  module Builders

    class QueueBuilder

      def self.from_node node
        item = Netflix4Ruby::Objects::QueueItem.new

        item.id_url = node.xpath('.//id').first.content
        item.id = item.id_url.split('/').last
        item.title = node.xpath('.//title').first[:regular]

        art = node.xpath('.//box_art').first
        item.box_art[:small] = art[:small]
        item.box_art[:medium] = art[:medium]
        item.box_art[:large] = art[:large]

        item.queue_availability = case queue_availability node
                                  when 'available now'; :available
                                  when 'available_now'; :available
                                  when 'saved'; :saved
                                  end

        item.raw = node.to_s

        item
      end

      def self.from_document document
        root = document.xpath('//queue')

        queue = Netflix4Ruby::Objects::Queue.new
        queue.number_of_results = root.xpath('.//number_of_results').first.content.to_i
        queue.start_index = root.xpath('.//start_index').first.content.to_i
        queue.results_per_page = root.xpath('.//results_per_page').first.content.to_i

        queue.items = document.xpath('//queue_item').collect { |node| from_node node }

        queue
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
