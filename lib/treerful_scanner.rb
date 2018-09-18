# frozen_string_literal: true

module TreerfulScanner
  Dir.glob("#{__dir__}/treerful_scanner/*.rb").each do |path|
    class_name = File.basename(path, '.rb').split('_').map(&:capitalize).join.to_sym
    autoload class_name, path
  end
end
