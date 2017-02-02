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
 xint = xint + i*xmint;
end;

xint = xint(:);
endfunction
