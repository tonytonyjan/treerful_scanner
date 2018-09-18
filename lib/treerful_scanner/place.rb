module TreerfulScanner
  class Place
    attr_accessor :id, :name, :images, :address, :volume, :url
    def initialize
      @images = []
    end
  end
end