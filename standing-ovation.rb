# Standing Ovation


T = gets.chomp.to_i

T.times do |i|

  shyness = gets.chomp.split[1]
  shyness_array = shyness.split('').map { |x| x.to_i }
  #p shyness_array

  standing = 0
  total_invites = 0
  shyness_array.size.times do |s|
    invites = 0
    if shyness_array[s] > 0 && s > standing
      invites = s - standing
      total_invites += invites
      #puts "shy: #{s} standing: #{standing} Convidando: " + invites.to_s
    end
    standing += shyness_array[s] + invites
  end
  puts "Case ##{i+1}: #{total_invites}"

end
