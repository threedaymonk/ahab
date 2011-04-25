require "strscan"

module HTMLEllipsis

  def ellipsize(str, max_length, ellipsis="…")
    scanner = StringScanner.new(str)
    tags = []
    length = 0
    output = ""
    while length < max_length && !scanner.eos?
      if scanner.scan(%r{&[^;]+;|[^<]})
        length += 1
      elsif scanner.scan(%r{<([^\s/>]+)[^>/]*/>})
        # zero length
      elsif scanner.scan(%r{<([^\s/>]+)[^>]*>})
        tags << scanner[1]
      elsif scanner.scan(%r{</([^\s/>]+)+\s*>})
        tags.pop
      end
      output << scanner.matched
    end
    output << ellipsis unless scanner.eos?
    tags.reverse_each do |tag|
      output << "</#{tag}>"
    end
    output
  end

  extend self
end
