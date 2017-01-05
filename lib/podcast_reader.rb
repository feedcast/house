require 'nokogiri'
require 'open-uri'
require 'open_uri_redirections'
require 'podcast_reader/podcast_reader_item'

class PodcastReader
  def initialize(url)
    @url = url
    @podcast = Nokogiri::XML(open(url, allow_redirections: :all))
    @items = []
    raise 'The supplied url is not a valid podcast rss' if @podcast.at_xpath('/rss').nil?
  end

  def title;            attr('/rss/channel/title');           end
  def description;      attr('/rss/channel/description');     end
  def language;         attr('/rss/channel/language');        end
  def last_build_date;  attr('/rss/channel/lastBuildDate');   end
  def site_link;        attr('/rss/channel/link');            end
  
  def image_url;        attr('/rss/channel/image/url');       end
  def image_title;      attr('/rss/channel/image/title');     end
  def image_link;       attr('/rss/channel/image/link');      end
  
  def author;           attr('/rss/channel/itunes:author');   end
  def subtitle;         attr('/rss/channel/itunes:subtitle'); end
  def summary;          attr('/rss/channel/itunes:summary');  end
  
  def keywords
    attr('/rss/channel/itunes:keywords').to_s.split(',')
  end
  
  def explicit?
    explicit = attr('/rss/channel/itunes:explicit')
    case explicit
      when 'yes' then true
      when 'no'  then false
    else
      nil
    end
  end

  def publish_date
    pub_date = attr('/rss/channel/pubDate') || attr('/rss/channel/item[1]/pubDate')
    Time.parse(pub_date)
  end
  
  def items
    if @items.empty? && @podcast.xpath('/rss/channel/item')
      @podcast.xpath('/rss/channel/item').each do |node|
        @items << PodcastReaderItem.new(node)
      end
    end
    @items
  end
  
  def download_image_to(file_path)
    dir_path = File.dirname(file_path)
    FileUtils.mkdir_p(dir_path) unless File.exist?(dir_path)
    File.open(file_path, 'w') do |f|
      f.write open(self.image_url).read
    end
  end
  
  def updated_since?(time)
    publish_date > time
  end
  
  private
  
  def attr(xpath)
    node = @podcast.xpath(xpath)
    if node.nil? || node.empty?
      nil
    else
      node.text
    end
  end
end