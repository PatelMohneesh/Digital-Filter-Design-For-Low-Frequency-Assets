

%Estimates the phase response phi from the amplitude response A of 
%a minimum phase system using the straight Hilbert Transform

function phi=amptophase(A)

N=length(A);
j=sqrt(-1);
theta=[0:N-1]*2*pi/N;
C=cot((theta+pi/N)/2);
c=j.*imag(ifft(C,N));
LA=log(A);
LA_t=real(ifft(LA,N));
phi=-real(fft(LA_t.*c,N));

end