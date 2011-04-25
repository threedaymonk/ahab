require "strscan"

module HTMLEllipsis
  class Ellipsizer
    def initialize
    end
  end

  def ellipsize(str, max_length)
    scanner = StringScanner.new(str)
    tags = []
    length = 0
    output = ""
    while length < max_length && !scanner.eos?
      if s = scanner.scan(%r{<([^\s/>]+)[^>/]*/>})
        output << s
      elsif s = scanner.scan(%r{<([^\s/>]+)[^>]*>})
        tags << scanner[1]
        output << s
      elsif s = scanner.scan(%r{</([^\s/>]+)+\s*>})
        tags.pop
        output << s
      elsif s = scanner.scan(%r{&[^;]+;})
        output << s
        length += 1
      elsif s = scanner.scan(%r{[^<]})
        output << s
        length += s.length
      end
    end
    if !scanner.eos?
      output << "…"
    end
    tags.reverse.each do |tag|
      output << "</#{tag}>"
    end
    output
  end

  extend self
end
