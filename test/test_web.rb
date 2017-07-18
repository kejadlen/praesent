require "web"

require "rack/test"

module Praesent
  class TestWeb < Minitest::Test
    include Rack::Test::Methods

    def app
      Web
    end

    def setup
      Web.set :slides, [
        Slide.new(content: "# Slide 1"),
        Slide.new(content: "# Slide 2", append: [ "- foo", "- bar", "- baz" ]),
      ]
    end

    def test_present
      get "/slide"
      assert last_response.ok?
      assert_includes last_response.body, "Slide 1"
    end
  end
end
