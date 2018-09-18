# frozen_string_literal: true

require 'eventmachine'
require 'em-http-request'
require 'treerful_scanner'

module TreerfulScanner
  class Client
    def initialize
      @parser = Parser.new
    end

    def search_by_date(date)
      date = date.to_s
      result = []
      EventMachine.run do
        conn = EventMachine::HttpRequest.new('https://www.treerful.com')
        client = conn.get path: '/space/result', keepalive: true
        client.callback do
          multi = EventMachine::MultiRequest.new
          places = @parser.parse_places(client.response)
          places.each do |place|
            client2 = conn.get path: "/space/allowTimes?id=#{place.id}&date=#{date}", keepalive: true
            client2.callback do
              time_table = TimeTable.new.tap do |table|
                table.date = date
                table.place = place
                table.durations = @parser.parse_time_bar_json(client2.response)
              end
              result << time_table
              yield time_table if block_given?
            end
            multi.add place.id, client2
          end

          multi.callback do
            conn.close
            EventMachine.stop
          end
        end
      end
      result
    end
  end
end
