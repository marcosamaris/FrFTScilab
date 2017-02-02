//FAST COMPUTATION OF THE FRACTIONAL FOURIER TRANSFORM 
//by M. Alper Kutay, September 1996, Ankara
//Copyright 1996 M. Alper Kutay
//This code may be used for scientific and educational purposes
//provided credit is given to the publications below:
//
//Haldun M. Ozaktas, Orhan Arikan, M. Alper Kutay, and Gozde Bozdagi,
//Digital computation of the fractional Fourier transform,
//IEEE Transactions on Signal Processing, 44:2141--2150, 1996. 
//Haldun M. Ozaktas, Zeev Zalevsky, and M. Alper Kutay,
//The Fractional Fourier Transform with Applications in Optics and
//Signal Processing, Wiley, 2000, chapter 6, page 298.
//
//The several functions given below should be separately saved
//under the same directory. fracF(fc,a) is the function the user
//should call, where fc is the sample vector of the function whose
//fractional Fourier transform is to be taken, and `a' is the
//transform order. The function returns the samples of the a'th
//order fractional Fourier transform, under the assumption that
//the Wigner distribution of the function is negligible outside a
//circle whose diameter is the square root of the length of fc.

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function[res]=fracF(fc,a);

// This function operates on the vector fc which is assumed to
// be the samples of a function, obtained at a rate 1/deltax 
// where the Wigner distribution of the function f is confined
// to a circle of diameter deltax around the origin. 
// (deltax^2 is the time-bandwidth product of the function f.)
// fc is assumed to have an even number of elements.
// This function maps fc to a vector, whose elements are the samples 
// of the a'th order fractional Fourier transform of the function f. 
// The lengths of the input and ouput vectors are the same if the 
// input vector has an even number of elements, as required.
// Operating interval: -2 <= a <= 2
// This function uses the `core' function corefrmod2.m

N = length(fc);
if fix(N/2) == N/2  
  error("Error el tamaño de la señal debe ser impar");
end;
fc = fc(:);

fc = bizinter(fc);
fc = [zeros(N,1); fc ; zeros(N,1)];

flag	= 0;

if (a>0) & (a<0.5)
   flag	= 1;
   a	= a-1;
end;
if (a>-0.5) & (a<0)
  flag	= 2;
  a	= a+1;
end;

if (a>1.5) & (a<2)
   flag	= 3;
   a	= a-1;
end;

if (a>-2) & (a<-1.5)
   flag	= 4;
   a	= a+1;
end;

res = fc;

if (flag==1) | (flag==3)
  res 	= corefrmod2(fc,1);
end;

if (flag==2) | (flag==4)
  res 	= corefrmod2(fc,-1);
end;

if (a==0)
  res	= fc;
else
if (a==2) | (a==-2)
  res	= flipud(fc);
else
  res	= corefrmod2(res,a);
end;
end;

res = res(N+1:3*N);
res = bizdec(res);
//res(1) = 2*res(1);
endfunction
