# Ominous Omino

T = gets.chomp.to_i

T.times do |i|
  
  winner = ""

  xrc = gets.chomp.split.map{ |x| x.to_i }

  area_rc = xrc[1] * xrc[2];

  if ( xrc.first * 2 > area_rc ) || ( area_rc % xrc.first != 0 ) 
    winner = "RICHARD"
  else
    winner = "GABRIEL"
  end 

  puts "Case ##{i+1}: #{winner}"

end
