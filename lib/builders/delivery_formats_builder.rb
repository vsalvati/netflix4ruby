module Netflix4Ruby

  module Objects

    class DeliveryFormat

      attr_accessor :label, :available_from, :available_until

      attr_accessor :raw

    end

  end

  module Builders

    class DeliveryFormatsBuilder

      def self.from_node node

        node.xpath('.//availability').collect { |n|
          fmt = Netflix4Ruby::Objects::DeliveryFormat.new

          fmt.label = categories(n, 'title_formats', :label).first
          fmt.available_from = time n['available_from']
          fmt.available_until = time n['available_until']

          fmt.raw = n.to_s
          fmt
        }

      end

      def self.from_document document
        formats = document.xpath('//delivery_formats').collect { |node| from_node node }
        formats.flatten
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

      def self.time string_value
        Time.at(string_value.to_i) unless string_value.nil? rescue nil
      end

    end

  end

end
