# frozen_string_literal: true

require 'treerful_scanner'
require 'erb'

module TreerfulScanner
  class HtmlPrinter < Printer
    attr_reader :date

    def initialize(*)
      super
      @template = IO.read("#{__dir__}/html_printer/template.erb")
    end

    def print
      erb = ERB.new(@template)
      erb.result(binding)
    end

    private

    def tbody
      "<tbody>#{@time_tables.map(&method(:to_tr)).join}</tbody>"
    end

    def to_tr(time_table)
      result = String.new
      result << "<tr><td><a href=\"https://www.treerful.com/space/#{time_table.place.id}\" rel=\"noopener noreferrer\" target=\"_blank\">#{time_table.place.name}</a></td><td>#{time_table.place.volume}</td>"
      result <<
        binary_form(time_table).each_char.map do |c|
          case c
          when ' ' then '<td></td>'
          when 'O' then '<td class="available"></td>'
          end
        end.join
      result << '</tr>'
    end
  end
end
