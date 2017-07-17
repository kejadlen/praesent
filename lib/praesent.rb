require "yaml"

require "kramdown"

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
        Slide.new(content: content, append: append)
      end
    end

    def initialize(content:, append: nil)
      @content = content
      @append = append || []
    end

    def transitions
      @append.each.with_object([@content]) {|i, n|
        n << "#{n.last}\n#{i}"
      }.map {|i| render(i) }
    end

    private

    def render(content)
      Kramdown::Document.new(content, input: :GFM, syntax_highlighter: :rouge).to_html
    end
  end
end
