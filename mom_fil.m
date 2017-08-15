

%Estimates coefficients of momentum filter by taking the difference 
%between the number of samples i.e. L2-L1 and returns a 
%filter of length L2.



function h=mom_fil(L1,L2,h0,h1)

h0(L1+1:L2)=0;
h=h1-h0;

end
