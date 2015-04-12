# Dijkstra

$quartenion = { 
  "11": "1", "1i": "i", "1j": "j", "1k": "k",
  "i1": "i", "ii": "-1", "ij": "k", "ik": "-j",
  "j1": "j", "ji": "-k", "jj": "-1", "jk": "i",
  "k1": "k", "ki": "j", "kj": "-i", "kk": "-1"
}

def find_m_with_pos(str, m, pos)
  #puts "find_m_with_pos(#{str}, #{m},#{pos})"
  return nil if str.empty? || pos >= str.size
  return 1 if pos == 0 && m == str.first
  value = str.first
  if pos > 0
    index = m + str[pos] 
    index = index.to_sym
    value = $quartenion[index].clone
    #puts "Index: #{index.inspect} Value: " + value
    if value == m
      return pos+1
    end
  end
  pos += 1
  str[pos..str.size].each do |x|
    if value =~ /-/
      negative = true
      value.gsub!('-','')
    end
    index = (value + x).to_sym
    value = $quartenion[index].clone
    if negative
      if value =~ /-/
        value.gsub!('-','')
      else
        value = "-" + value 
      end
    end
    pos += 1
    #puts "Value: #{value} X: #{x} quartenion[#{index.to_s}]: #{$quartenion[index]}"
    if value == m
      return pos
    end
  end
  return nil
end

def find_m(str, m)
  founds = []
  pos = 1
  value = str.first
  if value == m
    founds << pos
  end
  negative = false
  str.delete_at(0)
  str.each do |x|
    if value =~ /-/
      negative = true
      value.gsub!('-','')
    end
    index = (value + x).to_sym
    #puts "Value: #{value} X: #{x} quartenion[#{value+x}]: #{$quartenion[index]}"
    value = $quartenion[index].clone
    if negative
      if value =~ /-/
        value.gsub!('-','')
      else
        value = "-" + value 
      end
    end
    pos += 1
    if value == m
      founds << pos
    end
  end
  founds
end
   
def find_k(str, m)
  pos = 1
  value = str.first
  negative = false
  str[1..str.size].each do |x|
    if value =~ /-/
      negative = true
      value.gsub!('-','')
    end
    index = (value + x).to_sym
    #puts "Value: #{value} X: #{x} quartenion[#{value+x}]: #{$quartenion[index]}"
    value = $quartenion[index].clone
    if negative
      if value =~ /-/
        value.gsub!('-','')
      else
        value = "-" + value 
      end
    end
    pos += 1
  end
  if value == m
    return str[pos..str.size].size == 0
  end
  return false
end

def find_ijk(str)
  #find_m(str.clone, 'i').each do |pos_i|
  #  str_j = str[pos_i..str.size]
  #  #puts "pos_i: #{pos_i} size: #{str.size} #{str_j.inspect}"
  #  find_m(str_j.clone, 'j').each do |pos_j|

  #    str_k = str_j[pos_j..str_j.size]
  #    if find_k(str_k, "k")
  #      return true
  #    end
  #  end
  #end
  #p str
  v = find_m_with_pos(str, 'i', 0)
  while v 
    puts "v: #{v} str[v]: #{str[v]}"
    str_j = str[v..str.size]
    j = find_m_with_pos(str_j, 'j', 0)
    #puts "j: #{j}"
    while j
      str_k = str_j[j..str_j.size]
      puts "j: #{j}"
      if find_k(str_k, "k")
        return true
      end
      j = find_m_with_pos(str_j, 'j', j)
    end
    v = find_m_with_pos(str, 'i', v)
  end
  return false
end

#str = ["i", "k", "i", "i", "k"]
#v = find_m_with_pos(str, 'i', 0)
#while v 
#  puts "v: #{v} str[v]: #{str[v]}"
#  v = find_m_with_pos(str, 'i', v)
#end

T = gets.chomp.to_i

T.times do |i|

  result = "NO"

  lx = gets.chomp.split.map { |x| x.to_i }
  str = gets.chomp * lx.last
  str = str.split('') 

  result = "YES" if find_ijk(str)

  #if str
  #  str = find_m(str, 'j')
  #  if str
  #    str = find_k(str, 'k')
  #    if str && str.size == 0
  #      p str
  #      result = "YES"
  #    end
  #  end
  #end

  puts "Case ##{i+1}: #{result}"
end
