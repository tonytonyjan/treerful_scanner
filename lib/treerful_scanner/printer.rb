# frozen_string_literal: true

module TreerfulScanner
  class Printer
    BEGIN_HOUR = 6
    END_HOUR = 23
    TITLE_WIDTH = 20
    @time_tables = []

    def initialize(time_tables = [], date = nil)
      @time_tables = time_tables || []
      @date = date
    end

    def header
      format("%-#{TITLE_WIDTH}s", @date) << (BEGIN_HOUR..END_HOUR).map { |i| format('%-4s', i) }.join << "\n"
    end

    def row(time_table)
      fixed_string(time_table.place.name, TITLE_WIDTH) +
        binary_form(time_table).each_char.map { |i| format('%-2s', i) }.join +
        "\n"
    end

    def binary_form(time_table)
      result = String.new
      result << ' ' * (BEGIN_HOUR..END_HOUR).size * 2
      offset = BEGIN_HOUR * 60
      time_table.durations.each do |duration|
        start = (duration.from - offset) / 30
        finish = (duration.to - offset) / 30
        result[start...finish] = 'O' * (finish - start)
      end
      result
    end

    def print
      result = String.new
      result << header
      @time_tables.each do |table|
        result << row(table)
      end
      result
    end

    private

    def fixed_string(string, width)
      length = string.length + string.scan(/\p{Han}|\p{Katakana}|\p{Hiragana}\p{Hangul}/).length
      diff = width - length
      return string + (' ' * diff) if diff > 0
      string
    end
  end
end
