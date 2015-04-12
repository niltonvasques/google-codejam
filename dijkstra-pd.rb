class Dijkstra < String
  def *(value)
    self_negative = false
    value_negative = false
    self_cp = self.clone
    value_cp = value.clone
    if self =~ /-/
      self_negative = true
      self_cp.gsub!('-', '')
    end
    if value =~ /-/
      value_negative = true
      value_cp.gsub!('-', '')
    end
    res = case self_cp
    when '1'
      value_cp 
    when 'i' 
      case value_cp
      when '1'
        'i'
      when 'i'
        '-1'
      when 'j'
        'k'
      when 'k'
        '-j'
      end
    when 'j'
      case value_cp
      when '1'
        'j'
      when 'i'
        '-k'
      when 'j'
        '-1'
      when 'k'
        'i'
      end
    when 'k'
      case value_cp
      when '1'
        'k'
      when 'i'
        'j'
      when 'j'
        '-i'
      when 'k'
        '-1'
      end
    end
    if ( self_negative && !value_negative ) || ( !self_negative && value_negative)
      if res =~ /-/
        res.gsub!('-','')
      else
        res = "-" + res 
      end
    end
    #puts "try: " + self + " - " + value
    Dijkstra.new(res)
  end
end

def build_matrix(n, m)
  matrix = []
  n.times do |i|
    matrix[i] = [0] * m
  end
  matrix
end

def sub_mult(arr, matrix, i, j)
  return matrix[i][j] if matrix[i][j] != 0
  return arr[i] if i == j
  mid = (j-i)/2
  #puts "try matrix[#{i}][#{j}] mid: #{mid}"
  part1 = sub_mult(arr, matrix, i, i+mid)
  part2 = sub_mult(arr, matrix, i+mid+1, j)
  #puts "Part1: #{part1} Part2: #{part2}"
  matrix[i][j] =  part1 * part2
  #puts "matrix[#{i}][#{j}]: #{matrix[i][j]}"
  return matrix[i][j]
end

def find_neutros(dijkstra_arr, m, max)
  k_intervals = [] 
  max.times do |k|
    max_2 = max - k 
    max_2.times do |l|
      if sub_mult(dijkstra_arr, m, k, l+k) == '1'
        item = [k, l+k]
        k_intervals << item 
        break
      end
    end
  end
  return k_intervals
end

def find_ijk(dijkstra_arr, m, size)

  size -= 1
  k_intervals = []
  size.downto(0) do |k|
    if sub_mult(dijkstra_arr, m, k, size) == 'k'
      k_intervals << k
      #p dijkstra_arr[k..size].join if size - k < 50 
      #puts "k found #{k}~#{size}"
    end
  end

  return false if k_intervals.empty?

  #neutros_k = neutros.select { |x,y| y == k }

  i_intervals = []
  size += 1
  size.times do |i|
    if sub_mult(dijkstra_arr, m, 0, i) == 'i'
      i_intervals << i
      #puts "i found #{0}~#{i}"
    end
  end

  return false if i_intervals.empty?

  #puts "i max: #{i_intervals.max} k min: #{k_intervals.min}"

  i_intervals.each do |i|
    k_intervals.select! { |k| k > (i+1) }
    k_intervals.each do |k|
      if sub_mult(dijkstra_arr, m, i+1, k-1) == 'j'
        return true
      end
    end
  end

  #isize = size-1
  #isize.downto(0) do |i|
  #  if sub_mult(dijkstra_arr, m, 0, i) == 'i'
  #    puts "i found #{i}"
  #    jsize = size-i-1-1
  #    jsize.downto(0) do |j|
  #    #jsize.times do |j|
  #      if sub_mult(dijkstra_arr, m, i+1, i+1+j) == 'j'
  #        puts "j found #{i+1}~#{i+j+1}"
  #        ksize = jsize-j-1
  #        ksize.downto(0) do |k|
  #        #ksize.times do |k|
  #          if sub_mult(dijkstra_arr, m, i+j+2, size-1) == 'k'
  #            puts "k found #{i+j+1}~#{size-1}"
  #            return true
  #          end
  #        end
  #      end
  #    end
  #  end
  #end
  return false
end

#str = "jijijijijiji"
#size = 2*6
#m = build_matrix(size, size)
#p m
#
#arr = str.split('').map do |c|
#  case c
#  when 'i' #    1 #  when 'j' #    1000 #  when 'k'
#    500 #  end #end
#
#p arr
#
#puts sub_mult(arr, m, 0, size-1)

#i = Dijkstra.new('i')
#j = Dijkstra.new('j')
#k = Dijkstra.new('-k')
#puts j * k
#minusI = Dijkstra.new('-1')
#puts ( i * j ) * k
#puts minusI * k

T = gets.chomp.to_i

T.times do |i|

  result = "NO"

  lx = gets.chomp.split.map { |x| x.to_i }
  str0 = gets.chomp 
  str = str0 * lx.last
  str = str.split('') 

  dijkstra_arr = str.map{ |c| Dijkstra.new(c) }

  size = lx[0]*lx[1]

  m = build_matrix(size, size)

  #p dijkstra_arr[0]
  #p m
  #m[0][0] = dijkstra_arr[0] * dijkstra_arr[0]

  #p str
  if ((str0 =~ /i/ && str0 =~ /j/) || (str0 =~ /i/ && str0 =~ /k/) || (str0 =~ /j/ && str0 =~ /k/))
    #p find_neutros(dijkstra_arr, m, lx.first)
    if find_ijk(dijkstra_arr, m, size)
      result = "YES"
    end
  end

  #sub_mult(dijkstra_arr, m, 0, size-1)

  #result = "YES" if find_ijk(str)

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
