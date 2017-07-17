require "yaml"

module Praesent
  def self.load(yaml)
    YAML.load(yaml)
  end

  class Slide
    def initialize
    end
  end
end
