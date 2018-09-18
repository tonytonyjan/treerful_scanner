# frozen_string_literal: true

require 'minitest/autorun'
require 'treerful_scanner'
require 'json'

module TreerfulScanner
  class TestParser < Minitest::Test
    PLACE_HTML = IO.read("#{__dir__}/fixtures/place.html")
    PLACES_HTML = IO.read("#{__dir__}/fixtures/places.html")
    TIME_BAR_JSON = IO.read("#{__dir__}/fixtures/time_bar.json")
    TIME_BAR_JSON_2 = IO.read("#{__dir__}/fixtures/time_bar_2.json")
    TIME_BAR_HTML = JSON.parse(TIME_BAR_JSON)['timeBar']

    def setup
      @parser = Parser.new
    end

    def test_parse_place
      place = @parser.parse_place(PLACE_HTML)
      assert_equal '信義安和 A', place.name
      assert_equal '臺北市大安區信義路四段341號9樓-2-A', place.address
      assert_equal 16, place.volume
      assert_equal [
        'https://i.imgur.com/iFQtqYm.jpg',
        'https://i.imgur.com/8bRhvxM.jpg',
        'https://i.imgur.com/4xb9oJ4.jpg',
        'https://i.imgur.com/bjU11jY.jpg',
        'https://i.imgur.com/c50YqvF.jpg',
        'https://i.imgur.com/o4Bd80Z.jpg'
      ].sort!, place.images.sort
    end

    def test_parse_time_bar
      durations = @parser.parse_time_bar(TIME_BAR_HTML)
      assert_equal([[810, 870], [1110, 1230]], durations.map { |duration| [duration.from, duration.to] })
    end

    def test_parse_time_bar_with_variant_length
      durations = @parser.parse_time_bar_json(TIME_BAR_JSON_2)
      assert_equal([[420, 1110], [1380, 1410]], durations.map { |duration| [duration.from, duration.to] })
    end

    def test_parse_time_bar_json
      durations = @parser.parse_time_bar_json(TIME_BAR_JSON)
      assert_equal([[810, 870], [1110, 1230]], durations.map { |duration| [duration.from, duration.to] })
    end

    def test_parse_places
      assert_equal %w[10 101 102 103 104 105 11 110 111 112 113 114 115 116 117 118 119 12 121 122 123 124 125 15 16 17 18 19 20 21 22 23 24 25 3 31 4 41 5 51 6 62 63 64 65 66 67 68 69 7 70 71 72 73 74 75 76 77 78 79 8 80 81 82 83 84 85 86 87 88 89 9],
                   @parser.parse_places(PLACES_HTML).map(&:id).sort
    end
  end
end
