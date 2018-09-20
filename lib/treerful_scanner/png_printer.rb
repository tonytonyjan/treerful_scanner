# frozen_string_literal: true

require 'treerful_scanner'
require 'tmpdir'
require 'English'

module TreerfulScanner
  class PngPrinter < Printer
    CHROME_BINS = [
      'chromium-browser',
      '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'
    ].freeze
    WINDOW_HEIGHT_OFFSET = 200
    WINDOW_CELL_HEIGHT = 24.5

    def print
      html_printer = HtmlPrinter.new(@time_tables, @date)
      Dir.mktmpdir do |dir|
        html_path = "#{dir}/output.html"
        IO.write(html_path, html_printer.print)
        chrome_bin = CHROME_BINS.find{ |bin| system('which', bin, out: '/dev/null') } || ENV['CHROME_BIN']
        raise 'ENV["CHROME_BIN"] is nil' unless chrome_bin
        window_height = WINDOW_HEIGHT_OFFSET + WINDOW_CELL_HEIGHT * @time_tables.length
        Dir.chdir(dir) do
          raise "chrome exited with status #{$CHILD_STATUS}" unless system(
            chrome_bin,
            '--headless',
            '--disable-gpu',
            '--disable-software-rasterizer',
            '--disable-dev-shm-usage',
            '--no-sandbox',
            '--screenshot',
            '--hide-scrollbars',
            "--window-size=1280,#{window_height}",
            html_path
          )
          IO.read('screenshot.png', mode: 'rb')
        end
      end
    end
  end
end
