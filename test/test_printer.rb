# frozen_string_literal: true

require 'minitest/autorun'
require 'treerful_scanner'
require_relative 'helper'

module TreerfulScanner
  class TestPrinter < Minitest::Test
    include Test::Helper
    def test_print
      printer = Printer.new(*new_printer_params)
      assert_equal <<~EXPECTED, printer.print
        2018-09-10          6   7   8   9   10  11  12  13  14  15  16  17  18  19  20  21  22  23  
        Foo                         O O O O O O O O     O O     O O O O O O O O O O O O             
        Bar                                 O O O O O O O O     O O O O     O O O O O O             
        Buz                                     O O O O     O O O O     O O O O O O O O O O         
      EXPECTED
    end
  end
end
