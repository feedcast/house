require "spec_helper"

RSpec.describe House::Podcast do
  it "should accept a valid podcast url" do
    lambda { House::Podcast.new("http://podcasts.example.com/valid.xml") }.should_not raise_error
  end

  context "when the feed link redirects" do
    it "should not raise an error" do
      lambda { House::Podcast.new("http://podcasts.example.com/redirect.xml") }.should_not raise_error
    end
  end

  it "should raise exception when given an invalid podcast url" do
    lambda { House::Podcast.new("http://podcasts.example.com/invalid.xml") }.should raise_error
  end

  context "with a valid podcast url" do
    it "should have standard podcast attributes" do
      podcast = House::Podcast.new("http://podcasts.example.com/valid.xml")

      podcast.title.should_not be_nil
      podcast.description.should_not be_nil
      podcast.language.should_not be_nil
      podcast.publish_date.should_not be_nil
      podcast.last_build_date.should_not be_nil
      podcast.site_link.should_not be_nil

      podcast.image_url.should_not be_nil
      podcast.image_title.should_not be_nil
      podcast.image_link.should_not be_nil
    end

    it "should have the itunes podcast attributes" do
      podcast = House::Podcast.new("http://podcasts.example.com/valid_with_itunes.xml")

      podcast.keywords.should_not be_empty
      podcast.author.should_not be_nil
      podcast.subtitle.should_not be_nil
      podcast.summary.should_not be_nil
      podcast.explicit?.should be_false
    end

    it "should be valid without the itunes podcast attributes" do
      podcast = House::Podcast.new("http://podcasts.example.com/valid_without_itunes.xml")

      podcast.keywords.should be_empty
      podcast.author.should be_nil
      podcast.subtitle.should be_nil
      podcast.summary.should be_nil
      podcast.explicit?.should be_nil
    end

    it "should be valid without podcast items" do
      podcast = House::Podcast.new("http://podcasts.example.com/valid_without_items.xml")

      podcast.items.should be_empty
    end

    it "should have the correct amount of podcast items" do
      podcast = House::Podcast.new("http://podcasts.example.com/valid_with_2_items.xml")

      podcast.items.size.should == 2
    end

    context "with a podcast item" do
      it "should have the standard item attributes" do
        podcast = House::Podcast.new("http://podcasts.example.com/valid_with_2_items.xml")
        item = podcast.items.first
        item.title.should_not be_nil
        item.description.should_not be_nil
        item.url.should_not be_nil
      end

      it "should have the itunes item attributes" do
        podcast = House::Podcast.new("http://podcasts.example.com/valid_with_2_items.xml")
        item = podcast.items.first
        item.title.should_not be_nil
        item.subtitle.should_not be_nil
        item.keywords.should_not be_empty
        item.duration.should_not be_nil
        item.url.should_not be_nil
      end

      it "should be valid without the itunes item attributes" do
        podcast = House::Podcast.new("http://podcasts.example.com/valid_with_items_without_itunes.xml")
        item = podcast.items.first
        item.subtitle.should be_nil
        item.keywords.should be_empty
        item.duration.should be_nil
      end

      context "downloads" do
        before(:each) do
          @save_dir = "/tmp/rspec"
          @podcast = House::Podcast.new("http://podcasts.example.com/valid_with_2_items.xml")
          @item = @podcast.items.first
        end

        after(:each) do
          # remove any temp files
          Dir.foreach(@save_dir) do |f|
            file_to_remove = File.join(@save_dir, f)
            File.delete(file_to_remove) if f != "." && f != ".."
          end
        end

        it "allows the item to be downloaded to the specified directory" do
          @item.download_to(File.join(@save_dir, "example2.m4a"))
          File.exists?(File.join(@save_dir, "example2.m4a"))
        end

        it "allows the item to be converted to another format" do
          pending "Future consideration"
          # e.g.
          # @item.download_to(File.join(@save_dir, "example2.mp3"), "mp3")
          # File.exists?(File.join(@save_dir, "example2.mp3"))
        end

        it "allows the podcast image to be downloaded to the specified directory" do
          @podcast.download_image_to(File.join(@save_dir, "example2.jpg"))
          File.exists?(File.join(@save_dir, "example2.jpg"))
        end
      end
    end

    context "updated since" do
      it "will confirm if a newer version has been released" do
        podcast = House::Podcast.new("http://podcasts.example.com/valid_future.xml")
        podcast.updated_since?(Time.now).should be_true
        #check latest item/pubdate
      end

      it "will confirm if a newer version has NOT been released" do
        podcast = House::Podcast.new("http://podcasts.example.com/valid_past.xml")
        podcast.updated_since?(Time.now).should be_false
      end
    end
  end
end
