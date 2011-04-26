module HTMLRehead
  def rehead(str, top_level)
    existing = str.scan(/<h(\d)\b/).flatten.uniq.map{ |a| a.to_i(10) }.sort
    targets = (top_level ... (top_level + existing.length)).to_a.map{ |a| [a, 6].min }
    lookup = Hash[*existing.zip(targets).flatten]
    str.gsub(%r{(</?h)(\d)\b}){
      $1 + lookup[$2.to_i(10)].to_s
    }
  end

  extend self
end
