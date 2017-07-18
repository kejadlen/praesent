require "yaml"

module Praesent
  def self.load(yaml)
    YAML.load(yaml).map {|x| Slide.from(x) }
  end

  class Slide
    def self.from(raw)
      case raw
      when String
        Slide.new(content: raw)
      when Hash
        content = raw.fetch("content")
        append = raw["append"]
        notes = raw["notes"]
        Slide.new(content: content, append: append, notes: notes)
      end
    end

    attr_reader :notes

    def initialize(content:, append: nil, notes: nil)
      @content = content
      @append = append || []
      @notes = notes || ""
    end

    def transitions
      @append.each.with_object([@content]) {|i, n|
        n << "#{n.last}\n#{i}"
      }
    end
  end
end
