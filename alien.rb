# alien -rb
# input: 
# L D N
# w00w01w02...w0L 
# w10w11w12...w1L
# w20w21w22...w2L
# .
# .
# .
# wD0wD1wD2...wDL
require './btree.rb'
include BinaryTree

L = 0
D = 1
N = 2

# Handle input
input = gets.chomp.split
input.map! { |i| i.to_i }
$words = nil

input[D].times do 
  w = gets.chomp
  if $words == nil
    $words = BinaryTree::Node.new(w)
  else
    $words.push(w)
  end
end


def remove_brackets(str)
  str.gsub('(','').gsub(')', '')
end

def permute(list, word)
  if list.nil? || list.empty?
    #puts word 
    if $words.include?(word)
      $case += 1
    end
    return 
  end
  str = list.first
  if str =~ /\(\w+\)/
    str = remove_brackets(str)
    str.split('').each do |c|
      if $words.include_part?(word+c)
        permute(list[1..list.size], word+c)
      end
    end
  else
    permute(list[1..list.size], word+str)
  end
end

$case = 0
i = 1
input[N].times do
  t = gets.chomp
  pattern = t.scan(/\(\w+\)|\w+/)
  #p pattern
  permute(pattern, '')
  puts "Case ##{i}: #{$case}" 
  $case = 0
  i += 1
end

