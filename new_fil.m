

%estimates the filter coefficients of the minimum phase filter 
%design and returns the required filter

function h00=new_fil(L,N)

h0=mov_av(L);

%Filter Design for Length L1(MOMENTUM FILTER/L1)
H00=fft(h0,N);
A0=abs(H00);

%Amplitude 
A01=0.01*ones(1,N/2+1);
theta1=1.4*pi/L/6;
theta2=5*pi/L;
N1=round(N*theta1/(2*pi));
N2=round(N*theta2/(2*pi));
A01(1:N1)=A0(1:N1);
A01(N1+1:N2)=linspace(A0(N1),.0001,N2-N1);
A01=[A01 , A01(end-1:-1:2)];

phi01=amptophase(A01);

G01=A01.*exp(1i*phi01);
h00=ifft(G01,N);
h00=real(h00(1:L));
h00=h00/sum(h00);

end