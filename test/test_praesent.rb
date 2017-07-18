require "minitest/autorun"

require "praesent"

module Praesent
  class TestPraesent < Minitest::Test
    def test_praesent
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
  notes: |
    - Foo does some bar to baz.
      EOF

      assert_equal 2, slides.length
      assert_equal [1, 4], slides.map(&:transitions).map(&:length)

      assert_equal <<-MARKDOWN, slides[0].transitions.last
# Title

```ruby
def foo
  puts "Hello world!"
end
```
      MARKDOWN

      assert_equal "# Foobar\n", slides[1].transitions.first
      assert_equal <<-MARKDOWN.chomp, slides[1].transitions.last
# Foobar

- foo
- bar
- baz
      MARKDOWN

      assert_equal "- Foo does some bar to baz.\n", slides[1].notes
    end
  end
end
