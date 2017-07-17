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
      assert_equal [1, 4], slides.map(&:transitions).map(&:length)
    end
  end
end
