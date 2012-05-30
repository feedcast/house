require 'rspec'
require 'podcast_reader'
require 'sham_rack'

ShamRack.at("podcasts.example.com").sinatra do
  get "/:file_name" do
    File.read(File.join('spec', 'test_data', params[:file_name]))
  end
end