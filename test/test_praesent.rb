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
  notes: |
    - Foo does some bar to baz.
      EOF

      assert_equal 2, slides.length
      assert_equal [1, 4], slides.map(&:transitions).map(&:length)

      assert_equal <<-HTML, slides[0].transitions.last
<h1 id="title">Title</h1>

<pre><code class="language-ruby">def foo
  puts "Hello world!"
end
</code></pre>
      HTML

      assert_equal <<-HTML, slides[1].transitions.first
<h1 id="foobar">Foobar</h1>
      HTML
      assert_equal <<-HTML, slides[1].transitions.last
<h1 id="foobar">Foobar</h1>

<ul>
  <li>foo</li>
  <li>bar</li>
  <li>baz</li>
</ul>
      HTML

      assert_equal <<-HTML, slides[1].notes
<ul>
  <li>Foo does some bar to baz.</li>
</ul>
      HTML
    end
  end
end
