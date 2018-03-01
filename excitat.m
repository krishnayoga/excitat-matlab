function [output] = excitat(u)

	% Mencari nilai N, yaitu banyaknya data input u
	[row, column] = size(u);
	if row > column, N = row;
	else, N = column;
	end


	% Membuat tabel Rn, lalu mengisinya dengan Ruu(tau)
	Rn = zeros(N);
	for iterRow = 1:N
		for iterColumn = 1:N
			Rn(iterRow, iterColumn) = Ruu(iterColumn - iterRow, N, u);
		end
	end


	% Mencari orde eksitasi dari matrix Rn
	% Menguji sifat positive definite matrix Rn dengan Sylvester's criterion
	order = 0;
	for iterDet = 1:N
		if det(Rn(1:iterDet, 1:iterDet)) > 0
			order = order + 1;
		end
	end


	% Output dari program ini ialah orde eksitasi
	output = order;


	% Menghitung Ruu(tau)
	function outputRuu = Ruu(tau, N, u)
		val = 0;
		for iterRuu = 0:N-1
			if iterRuu == 0, b = 0;
			else, b = u(iterRuu);
			end
			if iterRuu + tau <= 0 || iterRuu + tau > N, a = 0;
			else, a = u(iterRuu + tau);
			end
			val = val + (a * b);
		end
		outputRuu = val/N;
	end
end