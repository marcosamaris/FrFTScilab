
function[y]=FrFT(fc,a);

N = length(fc);
if fix(N/2) ~= N/2  
  error("Error el tamaño de la señal debe ser par");
end;
fc = fc(:);   //Se coloca el vector de entrada como una sola columna para un mejor manejo del mismo

fc = bizinter(fc); // Se aumenta el tamaño de la señal de entrada a 2N
fc = [zeros(N,1); fc ; zeros(N,1)]; //Se coloca N zeros a la izquierda y a la derecha de la señal con el fin de 
                                    // evitar la superposición de la misma y así evitar el alliasing

bandera	= 0;      //Reducción del intervalo de análisis 0.5<|a|<1.5
if (a>0) & (a<0.5)
   bandera	= 1;
   a	= a-1;
end;
if (a>-0.5) & (a<0)
  bandera	= 2;
  a	= a+1;
end;

if (a>1.5) & (a<2)
   bandera	= 3;
   a	= a-1;
end;

if (a>-2) & (a<-1.5)
   bandera	= 4;
   a	= a+1;
end;

                                     //Casos particulares de la FrFT 
if (bandera==1) | (bandera==3)
  y 	= kernelFrFT(fc,1);
end;

if (bandera==2) | (bandera==4)
  y 	= kernelFrFT(fc,-1);
end;

if (a==0)
  y	= fc;
else
if (a==2) | (a==-2)
  y	= flipud(fc);
else
  y	= kernelFrFT(fc,a);     //En caso contrario de que el operador $a no sea entero sino fraccionario
end;
end;

y = y(N+1:3*N);       //La señal viene con tamaño 4N, por lo cual se toma solo el centro que es donde está la señal.
y = bizdec(y);        //Como el tamaño de la señal es 2N, se toma la mitad de las muestras para que quede del tamaño de la señal de entrada
endfunction
/////////////////%%%%%%%%%%%%%%%%FIN DE LA FUNCIÓN PRINCIPAL%%%%%%%%%%%%%%%////////////////////////////



/////////////////%%%%%%%%%%%%%%%% FUNCIÓN NÚCLEO DE FrFT %%%%%%%%%%%%%%%////////////////////////////
function[y]=kernelFrFT(fc,a);
alpha	= a*%pi/2;
N	= length(fc);

x	= [-ceil(N/2):fix(N/2)-1]/sqrt(N);
fc	= fc(:);
chirp1	= exp(%i*%pi*cos(alpha)*x.*x/N); //Declaración de una función chirp!
clear x;
chirp1	= chirp1(:);
fc  = fc.*chirp1;   // Multiplicación por la función chirp1
Hcfft	= fftshift(fft(fftshift(fc)));  // fft de la multiplicación de las muestras con la función Chirp1

Aphi	= exp(-%i*(%pi*sign(sin(alpha))/4-alpha/2))/sqrt(abs(sin(alpha))); //Se declara la constante C_a
chirp1	= chirp1(:);
y	= (Aphi*chirp1.*Hcfft);     //Se multiplica la constante, la función Chirp y el resultado de la fft
clear Hcfft;
clear chirp1;
clear Hc
clear Aphi;

if (fix(N/2) ~=N/2)
  y2(1:N-1) = y(2:N);
  y2(N)     = y(1);
  y     = y2;
end;

y = y(:);
endfunction


/////////////////%%%%%%%%%%%%%%%% FUNCIÓN DE INTERPOLACIÓN %%%%%%%%%%%%%%%////////////////////////////
function xint=bizinter(x)

N=length(x);
im = 0;
if sum(abs(imag(x)))>0
  im = 1;
  imx = imag(x);
  x  = real(x);
end;

x2=x(:);
x2=[x2.'; zeros(1,N)];
x2=x2(:);
xf=fft(x2);
if modulo(N,2)==1      //N = odd
	N1=fix(N/2+1); N2=2*N-fix(N/2)+1;
	xint=2*real(ifft([xf(1:N1); zeros(N,1)  ;xf(N2:2*N)].'));
else
	xint=2*real(ifft([xf(1:N/2); zeros(N,1)  ;xf(2*N-N/2+1:2*N)].'));
end;
if ( im == 1)
 x2=imx(:);
 x2=[x2.'; zeros(1,N)];
 x2=x2(:);
 xf=fft(x2);
 if modulo(N,2)==1      //N = odd
	N1=fix(N/2+1); N2=2*N-fix(N/2)+1;
	xmint=2*real(ifft([xf(1:N1); zeros(N,1)  ;xf(N2:2*N)].'));
 else
	xmint=2*real(ifft([xf(1:N/2); zeros(N,1)  ;xf(2*N-N/2+1:2*N)].'));
 end;
 xint = xint + %i*xmint;
end;

xint = xint(:);
endfunction


/////////////////%%%%%%%%%%%%%%%% FUNCIÓN DECIMACION %%%%%%%%%%%%%%%////////////////////////////
function xdec=bizdec(x)

k = 1:2:length(x);
xdec = x(k);

xdec = xdec(:);
endfunction


//function F2D=fracF2D(f2D,ac,ar)
//
//[M,N] = size(f2D);
//F2D = zeros(M,N);
//
//if ac == 0
//   F2D = f2D;
//else
//   for k = 1:N
//     F2D(:,k) = FrFT(f2D(:,k),ac);
//   end;
//end;
//
//
//F2D = conj(F2D');
//
//if ar ~= 0
//	for k = 1:M
//   	F2D(:,k) = FrFT(F2D(:,k),ar);
//	end;
//end;
//
//F2D = conj(F2D');
//
//
//endfunction
