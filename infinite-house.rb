# Infinitely House of Pancakes
class SortedArray < Array

  def self.[] *array
    SortedArray.new(array)
  end

  def initialize array=nil
    super( array.sort ) if array
  end

  def << value
    insert index_of_last_LE(value), value
  end

  alias push <<
  alias shift <<

  def index_of_last_LE value
    # puts "Insertgin #{value} into #{inspect}"
    l,r = 0, length-1
    while l <= r
      m = (r+l) / 2
      # puts "#{l}(#{self[l]})--#{m}(#{self[m]})--#{r}(#{self[r]})"
      if value < self[m]
        r = m - 1
      else
        l = m + 1
      end
    end
    # puts "Answer: #{l}:(#{self[l]})"
    l
  end
end

def second_max(list, rest)
  if list.size == 1
    return rest
  end
  if list[list.size-2] > rest
    list[list.size-2]
  else
    rest
  end
end

def lift(list, minutes)
  max = list.last
  time_to_end = max + minutes
  if max == 1
    return time_to_end
  end
  lifted = max/2
  if max > 4 && max % 2 != 0
    lifted -= 1
  end
  rest = max - lifted
  #puts "Max #{max} SencondMax #{second_max(list, rest)}"
  #p list
  list.pop
  list << rest
  list << lifted
  #list.map!{ |x| x > 0 ? x-1 : 0 }
  new_time_to_end2 = lift(list, minutes+1)
  return (time_to_end < new_time_to_end2) ? time_to_end : new_time_to_end2
end


def lift_2(list, minutes)
  max = list.last
  time_to_end = max + minutes
  if max == 1
    return time_to_end
  end
  lifted = max/2
  rest = max - lifted
  #puts "Max #{max} SencondMax #{second_max(list, rest)}"
  #p list
  list.pop
  list << rest
  list << lifted
  #list.map!{ |x| x > 0 ? x-1 : 0 }
  new_time_to_end2 = lift_2(list, minutes+1)
  return (time_to_end < new_time_to_end2) ? time_to_end : new_time_to_end2
end

def lift_linear(list, minutes, way = :method1)

  max = list.last
  time_to_end = max + minutes
  while max > 1
    lifted = max/2
    if way == :method1
      if max > 4 && max % 2 != 0
        lifted -= 1
      end
    end
    rest = max - lifted
    list.pop
    list << rest
    list << lifted
    minutes += 1
    max = list.last
    time_to_end = max + minutes if time_to_end > (max + minutes)
    if ( (max + minutes) - time_to_end ) > 50
      break
    end
  end
  return time_to_end
end

T = gets.chomp.to_i


T.times do |i|

  time = 0

  d = gets.chomp.to_i
  pancakes = gets.chomp.split.map{ |p| p.to_i }
  sorted_array = SortedArray.new(pancakes)

  way1 = lift_linear(sorted_array.clone, 0)
  way2 = lift_linear(sorted_array.clone, 0, :method2)
  
  time = way1 < way2 ? way1 : way2

  puts "Case ##{i+1}: #{time}"

end
