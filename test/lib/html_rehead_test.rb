require File.expand_path("../common", __FILE__)
require "html_utils"

class HTMLReheadTest < Test::Unit::TestCase
  include HTMLUtils

  def test_should_renumber_all_headings_up_from_specified_offset
    input    = "<h3>foo</h3><h4>bar</h4><h5>baz</h5>"
    expected = "<h2>foo</h2><h3>bar</h3><h4>baz</h4>"
    assert_equal expected, rehead(input, 2)
  end

  def test_should_renumber_all_headings_down_from_specified_offset
    input    = "<h1>foo</h1><h2>bar</h2><h3>baz</h3>"
    expected = "<h2>foo</h2><h3>bar</h3><h4>baz</h4>"
    assert_equal expected, rehead(input, 2)
  end

  def test_should_eliminate_gaps_in_heading_ordering
    input    = "<h1>foo</h1><h4>bar</h4><h5>baz</h5>"
    expected = "<h2>foo</h2><h3>bar</h3><h4>baz</h4>"
    assert_equal expected, rehead(input, 2)
  end

  def test_should_cut_off_at_h6
    input    = "<h3>foo</h3><h4>bar</h4><h5>baz</h5>"
    expected = "<h5>foo</h5><h6>bar</h6><h6>baz</h6>"
    assert_equal expected, rehead(input, 5)
  end
end
