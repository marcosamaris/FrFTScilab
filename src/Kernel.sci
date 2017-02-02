function[res]=corefrmod2(fc,a);

// Core function for computing the fractional Fourier transform.
// Valid only when 0.5 <= abs(a) <= 1.5
// Decomposition used: 
//   chirp mutiplication - chirp convolution - chirp mutiplication

deltax	= sqrt(length(fc));

phi	= a*%pi/2;
N	= fix(length(fc));
deltax1 = deltax;
alpha	= 1/tan(phi);
Beta	= 1/sin(phi);

x	= [-ceil(N/2):fix(N/2)-1]/deltax1;
fc	= fc(:);
fc	= fc(1:N);
f1	= exp(-%i*%pi*tan(phi/2)*x.*x); //multiplication by chirp!
f1	= f1(:);
fc  = fc.*f1;
x	= x(:);
clear x;
t	=[-N+1:N-1]/deltax1;
hlptc	=exp(%i*%pi*Beta*t.*t);
clear t;
hlptc	= hlptc(:);

N2	= length(hlptc);
N3	= 2^(ceil(log(N2+N-1)/log(2)));
hlptcz	= [hlptc;zeros(N3-N2,1)];
fcz	= [fc;zeros(N3-N,1)];
Hcfft	= ifft(fft(fcz).*fft(hlptcz));  // convolution with chirp
clear hlptcz;
clear fcz;
Hc	= Hcfft(N:2*N-1);
clear Hcfft;
clear hlptc;
Aphi	= exp(-%i*(%pi*sign(sin(phi))/4-phi/2))/sqrt(abs(sin(phi)));
xx	= [-ceil(N/2):fix(N/2)-1]/deltax1;
f1	= f1(:);        
res	= (Aphi*f1.*Hc)/deltax1;  // multiplication by chirp!

if (fix(N/2) ~=N/2)
  res2(1:N-1) = res(2:N);
  res2(N)     = res(1);
  res     = res2;
end;

res = res(:);

clear f1
clear Hc
endfunction
