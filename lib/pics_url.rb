require 'nokogiri'
require 'open-uri'
require 'httparty'
require 'pry'

module PicsUrl
  class Images
    include HTTParty

    attr_reader :url

    def initialize(url)
      @url = url
    end

    def links
      html.search('//img/@src')
        .map { |s| (s.value).gsub('/thumbs', '') }
        .select { |z| z =~ /.*\.jpg|svg|png/ }
        .collect { |a|
          if a =~ /http/
           a
          elsif a =~ /.net/
            "http:" + a
          else
            host + '/' + a
          end
        }
    end

    private

    def response
      HTTParty.get(url)
    end

    def html
      Nokogiri::HTML(response.body)
    end

    def host
      open(url).base_uri.to_s
    end
  end
end
