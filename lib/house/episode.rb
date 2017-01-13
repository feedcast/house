require "nokogiri"
require "open-uri"

module House
  class Episode
    def initialize(item_node)
      @item_xml = item_node
    end

    def title;            item_attr("title");               end
    def description;      item_attr("description");         end
    def category;         item_attr("category");            end

    def author;           item_attr("itunes:author");       end
    def subtitle;         item_attr("itunes:subtitle");     end
    def summary;          item_attr("itunes:summary");      end
    def duration;         item_attr("itunes:duration");     end

    def url;              item_attr("enclosure", "url");    end
    def content_type;     item_attr("enclosure", "size");   end
    def file_size;        item_attr("enclosure", "length"); end


    def keywords
      item_attr("itunes:keywords").to_s.split(",")
    end

    def explicit?
      explicit = item_attr("itunes:explicit")
      case explicit
      when "yes" then true
      when "no"  then false
      else
        nil
      end
    end

    def block?
      block = item_attr("itunes:block")
      case block
      when "yes" then true
      when "no"  then false
      else
        nil
      end
    end

    def publish_date
      Time.parse(item_attr("pubDate")) if item_attr("pubDate")
    end

    def download_to(file_path)
      dir_path = File.dirname(file_path)
      FileUtils.mkdir_p(dir_path) unless File.exist?(dir_path)
      File.open(file_path, "w") do |f|
        f.write open(self.url).read
      end
    end

    private

    def item_attr(xpath, attribute = nil)
      node = @item_xml.xpath(xpath)
      if node.nil? || node.empty?
        nil
      else
        if attribute.nil?
          node.text
        elsif node.attr(attribute)
          node.attr(attribute).value
        end
      end
    end
  end
end
