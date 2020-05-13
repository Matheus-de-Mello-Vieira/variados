class Bit
	attr_accessor :valor
	def initialize(valor)
		@valor = valor;
		if valor == 0
			@valor = false;
		end
	end
	def !
		Bit.new(!@valor)
	end
	def + (valor1)
		Bit.new(@valor||valor1.valor);
	end
	def *(bit1)
		Bit.new(@valor&&bit1.valor);
	end
	
	def to_b
		return @valor;
	end
	
	def to_s
		return @valor? "1":"0";
	end
end

class Byte
	attr_accessor :bits
	def initialize(bits)
		@bits = bits;
	end
	def !
		Byte.new @bits.map{|i| !i}
	end
	def + (byte1)
		result = [];
		@bits.size.times do |i|
			result << @bits[i] + byte1.bits[i]
		end
		Byte.new result
	end
	def *(byte1)
		result = [];
		@bits.size.times do |i|
			result << @bits[i] * byte1.bits[i]
		end
		Byte.new result;
	end
	def to_s
		result = "";
		@bits.each{|i| result<<i.to_s}
		return result;
	end
end
class Estoque

end;

print "Insira a operação: "
operacao = gets.chomp.downcase;

est = Estoque.new
variaveis = operacao.scan(/[a-z]/).uniq;
numeroDeLinhas = 2 ** variaveis.size;
variaveis.size.times do
	|i|
	atual = false;
	bits = [];
	quantidadeInvertores = 2 ** (i+1);
	quantidadeCada = numeroDeLinhas/(quantidadeInvertores);
	quantidadeInvertores.times do
		quantidadeCada.times do
			bits << Bit.new(atual);
		end
		atual = !atual;
	end
	est.instance_variable_set("@#{variaveis[i]}", Byte.new(bits)) 
	eval("def est.#{variaveis[i]}; return @#{variaveis[i]}; end")
	operacao = operacao.gsub("#{variaveis[i]}",":::#{variaveis[i]}")
	puts variaveis[i] + ": " +Byte.new(bits).to_s;
end

operacao = operacao.gsub(":::","est.")
puts "S: "+eval(operacao).to_s;