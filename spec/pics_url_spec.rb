require 'spec_helper'

RSpec.describe PicsUrl do
  let(:raw_page_html) { File.open("spec/support/resp.html").read }
  let(:html) { Nokogiri::HTML.parse raw_page_html }
  let(:url) { "http://annazabrodina.com" }
  let(:links) {
    ["http://annazabrodina.com/storage/logo/u-@2x.png?version=335",
      "http://static1.vigbo.com/u23024/27943/photos/2392004/1000-anna_zabrodina-d16c7ed4db67485f06d7dcecdadb9991.jpg",
      "http://static1.vigbo.com/u23024/27943/photos/2392004/1000-anna_zabrodina-e015c43d4c2a0e95268dc600963fd09a.jpg",
      "http://static1.vigbo.com/u23024/27943/photos/2392004/1000-anna_zabrodina-404a54c15b67538011f17e58dfbafe1d.jpg",
      "http://static1.vigbo.com/u23024/27943/photos/2392004/-anna_zabrodina-d16c7ed4db67485f06d7dcecdadb9991.jpg",
      "http://static1.vigbo.com/u23024/27943/photos/2392004/-anna_zabrodina-e015c43d4c2a0e95268dc600963fd09a.jpg",
      "http://static1.vigbo.com/u23024/27943/photos/2392004/-anna_zabrodina-404a54c15b67538011f17e58dfbafe1d.jpg"]
  }

  subject {
    PicsUrl::Images.new(url)
  }

  it 'should response page_html' do
    allow(HTTParty).to receive(:get).and_return(raw_page_html)
  end

  it 'should return a certain number of links' do
    expect(subject.links.count).to eq(7)
  end

  it 'should return current links' do
    expect(subject.links).to eq(links)
  end
end
