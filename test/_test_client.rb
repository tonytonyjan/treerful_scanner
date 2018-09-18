# frozen_string_literal: true

require 'minitest/autorun'
require 'treerful_scanner'

module TreerfulScanner
  class TestClient < Minitest::Test
    def setup
      @client = Client.new
    end

    def test_search_by_date
      @client.search_by_date('2018-09-19')
    end
  end
end
