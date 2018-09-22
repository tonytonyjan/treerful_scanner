# frozen_string_literal: true

require 'minitest/autorun'
require 'treerful_scanner'
require_relative 'helper'

module TreerfulScanner
  class TestHtmlPrinter < Minitest::Test
    include Test::Helper
    def test_to_tr
      printer = HtmlPrinter.new(*new_printer_params)
      time_table = TimeTable.new.tap do |table|
        table.date = '2018-09-09'
        table.place = Place.new.tap do |place|
          place.id = '123'
          place.name = 'Foo'
          place.volume = 12
        end
        table.durations = [
          new_duration(9, 10),
          new_duration(13, 15),
          new_duration(18, 21.5)
        ]
      end
      assert_equal(
        '<tr><td><a href="https://www.treerful.com/space/123" rel="noopener noreferrer" target="_blank">Foo</a></td><td>12</td><td></td><td></td><td></td><td></td><td></td><td></td><td class="available"></td><td class="available"></td><td></td><td></td><td></td><td></td><td></td><td></td><td class="available"></td><td class="available"></td><td class="available"></td><td class="available"></td><td></td><td></td><td></td><td></td><td></td><td></td><td class="available"></td><td class="available"></td><td class="available"></td><td class="available"></td><td class="available"></td><td class="available"></td><td class="available"></td><td></td><td></td><td></td><td></td></tr>',
        printer.send(:to_tr, time_table)
      )
    end

    private

    def new_duration(from, to)
      Duration.new(from * 60, to * 60)
    end
  end
end
