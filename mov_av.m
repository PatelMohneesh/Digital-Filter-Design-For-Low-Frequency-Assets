
%Estimates the filter coefficients of moving average filter of the specified length

function h= mov_av(L)

h=ones(1,L)/L;
h=h/sum(h);

end