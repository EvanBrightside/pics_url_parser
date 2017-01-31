require 'nokogiri'
require 'open-uri'
require 'httparty'
require 'pry'

module PicsUrl
  class Images
    include HTTParty

    def self.links

      puts "Enter url"

      url = gets.chomp

      response = HTTParty.get(url)

      html = Nokogiri::HTML(response.body)

      host = open(url).base_uri.to_s

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

    puts links
  end
end
