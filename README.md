<p align="center">
  <img src="https://raw.githubusercontent.com/feedcast/house/master/docs/logo.png" width="200">
  <h1 align="center" style="margin-top: -50px">House</h1>
  <p align="center">:pill: The Podcast RSS Reader and Diagnostician<p>
</p>

> :round_pushpin: This is a refactor/fork of [kule/podcast_reader](https://github.com/kule/podcast_reader), thanks [@kule](/kule) for the efforts so far!

## Installation

Add this line to your application's Gemfile:

```ruby
gem "house.rb"
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install house.rb
```

## Usage

```ruby
require "house.rb"

podcast = House::Podcast.new("http://feeds.feedburner.com/developertea")

pocast.title
pocast.description
pocast.title
pocast.description
pocast.language
pocast.last_build_date
pocast.site_link

podcast.image_url
podcast.image_title
podcast.image_link

podcast.author
podcast.subtitle
podcast.summary

podcast.publish_date

podcast.keywords
podcast.explicit?
podcast.download_image_to("./podcast_image.jpg")
podcast.updated_since(Time.now)
podcast.items.size

episode = podcast.items.first

episode.title
episode.description
episode.category
episode.author
episode.subtitle
episode.summary
episode.duration
episode.url
episode.content_type
episode.file_size

episodes.download_to("./podcast_track.mp3")
```
