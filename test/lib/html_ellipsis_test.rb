# coding: utf-8
require File.expand_path("../common", __FILE__)
require "html_utils/ellipsis"

class HTMLEllipsisTest < Test::Unit::TestCase
  include HTMLUtils

  def test_should_shorten_to_desired_length_with_ellipsis
    input    = "foo bar"
    expected = "foo …"
    assert_equal expected, ellipsize(input, 4)
  end

  def test_should_not_shorten_if_not_necessary
    input    = "foo"
    expected = "foo"
    assert_equal expected, ellipsize(input, 4)
  end

  def test_should_not_include_html_in_length
    input    = "foo <a>bar</a> baz"
    expected = "foo <a>bar</a> ba…"
    assert_equal expected, ellipsize(input, 10)
  end

  def test_should_close_opened_tags_in_reverse_order
    input    = "<aaa><bbb n=1>bar</bbb> <ccc n=1>baz and more text goes here"
    expected = "<aaa><bbb n=1>bar</bbb> <ccc n=1>baz an…</ccc></aaa>"
    assert_equal expected, ellipsize(input, 10)
  end

  def test_should_ignore_self_closing_tags
    input    = "foo <aaa /> <bbb/> bar baz"
    expected = "foo <aaa /> <bbb/> bar …" 
    assert_equal expected, ellipsize(input, 10)
  end

  def test_should_count_entities_as_length_one
    input    = "foo&lt;bar"
    expected = "foo&lt;b…" 
    assert_equal expected, ellipsize(input, 5)
  end

  def test_should_consider_all_codepoints_as_length_one
    input    = "いろはにほへと"
    expected = "いろは…"
    assert_equal expected, ellipsize(input, 3)
  end
end
