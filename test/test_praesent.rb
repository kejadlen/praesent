require "minitest/autorun"

require "praesent"

module Praesent
  class TestPraesent < Minitest::Test
    def test_integrations
      slides = Praesent.load(<<-EOF)
- |
  # Title

  ```ruby
  def foo
    puts "Hello world!"
  end
  ```

- content: |
    # Foobar
  append:
    - "- foo"
    - "- bar"
    - "- baz"
      EOF

      assert_equal 2, slides.length
    end
  end
end
