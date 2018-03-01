function [output] = exitat(u)

% Menentukan ukuran matriks data
[baris, kolom] = size(u);
	if baris > kolom, N = baris;
	else, N = kolom;
    end 
    
% Menentukan matriks Rn    
Rn = zeros(N);
	for iterBaris = 1:N
		for iterKolom = 1:N
			Rn(iterBaris, iterKolom) = Ruu(iterKolom - iterBaris, N, u);
		end
    end

% Mendefinisikan nilai variable
i =1;
mat = size(Rn);
count = 0;

% Check determinan setiap ukuran matriks data
while i <= mat
    matSz = Rn(1:i, 1:i);
    detCheck = det(matSz);
    
    % Menentukan orde eksitasi dari determinan tiap matriks data
    if detCheck > 0
        count = count+1;
    else
        count = count+0;
    end
    
    i=i+1;
end
output = count;

% Menentukan nilai Ruu
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