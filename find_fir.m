%Name - Mohneesh Patel
%MS Electrical Engineering
%Columbia University
%Digital Signal Processing Project

%Matches frequency of pass band edge and returns the 
%corresponding index from the range of frequencies.


function [z]=find_fir(w,k)

a=w>k;
h=find(a);
z=h(1);

end