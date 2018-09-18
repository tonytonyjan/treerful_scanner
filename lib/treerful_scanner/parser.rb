# frozen_string_literal: true

require 'nokogiri'
require 'treerful_scanner'
require 'json'

module TreerfulScanner
  class Parser
    def parse_place(html)
      doc = Nokogiri::HTML(html)
      Place.new.tap do |place|
        place.name = doc.at_css('.locationTitleLeft > h3:nth-child(1)').text
        place.address = doc.at_css('.locationTitleLeft > p:nth-child(2)').text
        place.volume = doc.at_css('.capacity').text[/\d+/].to_i
        place.images = doc.css('img.singlePhoto').map { |element| element[:src] }
      end
    end

    def parse_time_bar_json(json)
      parse_time_bar(JSON.parse(json)['timeBar'])
    end

    def parse_time_bar(html)
      doc = Nokogiri::HTML(html)
      result = String.new
      doc.css('.availability').each do |element|
        result << 1 if element.classes.include?('enabled')
        result << 0 if element.classes.include?('disabled')
      end
      start_time = doc.at_css('.availability-hours-label').text.to_i * 60
      time_mapping = start_time.step(by: 30).take(result.size + 1)
      durations = []
      result.scan(/\x01+/) do
        durations << Duration.new(*Regexp.last_match.offset(0).map { |id| time_mapping[id] })
      end
      durations
    end

    def parse_places(html)
      doc = Nokogiri::HTML(html)
      doc.css('div.canbook ul li a').map do |element|
        Place.new.tap do |place|
          place.url = element['href']
          place.id = element['href'][%r{/space/(\d+)}, 1]
          place.name = element.at_css('h3').text
          place.volume = element.at_css('p').text[/\d+/].to_i
          place.images << element.at_css('.bookingImg')['style'][/url\(['"]?([^'")]+)['"]?\)/, 1]
        end
      end
    end
  end
end
