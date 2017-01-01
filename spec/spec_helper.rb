require 'rspec'
require 'podcast_reader'
require 'sham_rack'
require 'rack'

ShamRack.at("podcasts.example.com").sinatra do
  get "/redirect.xml" do
    res = Rack::Response.new
    res.redirect("/valid.xml")
    res.write("302 you've redirected")
    res.finish
  end

  get "/:file_name" do
    File.read(File.join('spec', 'test_data', params[:file_name]))
  end
end
