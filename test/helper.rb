# frozen_string_literal: true

require 'treerful_scanner'

module TreerfulScanner
  module Test
    module Helper
      def new_printer_params
        [
          [
            new_time_table(
              place: new_place(name: 'Foo'), durations: [
                new_duration(8, 12), new_duration(13, 14), new_duration(15, 21)
              ]
            ),
            new_time_table(
              place: new_place(name: 'Bar'), durations: [
                new_duration(10, 14), new_duration(15, 17), new_duration(18, 21)
              ]
            ),
            new_time_table(
              place: new_place(name: 'Buz'), durations: [
                new_duration(11, 13), new_duration(14, 16), new_duration(17, 22)
              ]
            )
          ], '2018-09-10'
        ]
      end

      def new_time_table(**params)
        TimeTable.new.tap do |table|
          params.each do |key, value|
            table.send("#{key}=", value)
          end
        end
      end

      def new_place(**params)
        Place.new.tap do |place|
          params.each do |key, value|
            place.send("#{key}=", value)
          end
        end
      end

      def new_duration(from, to)
        Duration.new(from * 60, to * 60)
      end
    end
  end
end
