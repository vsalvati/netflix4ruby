module Netflix4Ruby

  module Objects

    class CatalogTitle

      attr_accessor :title, :id, :id_url,
                    :box_art_small, :box_art_medium, :box_art_large,
                    :mpaa_rating, :tv_rating

      attr_accessor :raw

      def rating
        mpaa_rating || tv_rating
      end

    end

  end

  module Builders

    class CatalogTitleBuilder

      def self.from_node node
        title = Netflix4Ruby::Objects::CatalogTitle.new

        title.id_url = node.xpath('.//id')[0].content
        title.id = title.id_url.split('/')[-1]
        title.title = node.xpath('.//title')[0][:regular]

        art = node.xpath('.//box_art')[0]
        title.box_art_small = art[:small]
        title.box_art_medium = art[:medium]
        title.box_art_large = art[:large]

        title.mpaa_rating = mpaa_rating node
        title.tv_rating = tv_rating node

        title.raw = node.to_s

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

      def self.category node, scheme, attr
        scheme = "http://api.netflix.com/categories/#{scheme}"
        cat = node.xpath(".//category[@scheme=$scheme]", nil, :scheme => scheme)
        cat[0][attr] unless cat.empty?
      end

      def self.link node, rel, attr
        rel = "http://schemas.netflix.com/#{rel}"
        link = node.xpath(".//link[@rel=$rel]", nil, :rel => rel)
        link[0][attr] unless link.empty?
      end

      def self.mpaa_rating node
        category node, "mpaa_ratings", :label
      end

      def self.tv_rating node
        category node, "tv_ratings", :label
      end

    end

  end

end
