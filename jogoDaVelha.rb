tabuleiro = [[0,0,0],[0,0,0],[0,0,0]]
caracteres = ["X","O"];
jogador = 1;
somatorios = [[0,0,0],[0,0,0],[0,0]]

loop do
	print "Vez do jogador #{(3-jogador)/2}: ";
	jogada = gets.chomp
	
	unless(jogada.match(/ ?\d ?,? ?\d ?/))
		puts "Formato errado"
		next;
	end
	
	x,y = jogada.scan(/\d/).map{|i| i.to_i-1};
	
	unless ((0..2).include? x) && ((0..2).include? y)
		puts "Posição invalida"
		next;
	end
	
	if(tabuleiro[x][y] == 0)
		tabuleiro[x][y] = jogador;
		somatorios[0][x]+= jogador;
		somatorios[1][y]+= jogador;
		somatorios[2][0]+=jogador if x==y;
		somatorios[2][1]+=jogador if x+y==4;
	else
		puts "Posição ocupada"
		next;
	end
	
	for i in 0..2
		for j in 0..2
			print "#{tabuleiro[i][j]}\t"
		end
		puts
	end
	
	somatorios.each do |i|
		i.each do |j|
			if j == 3
				puts "O jogador 1 ganhou!"
				break;
			end
			if j == 6
				puts "O jogador 2 ganhou!"
				break;
			end
		end
	end
	jogador*= -1;
end