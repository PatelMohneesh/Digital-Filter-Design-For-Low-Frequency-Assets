

%Estimates the no of crossover points or no of points 
%where the financial signal crosses the x-axis

function [t1,t2,ratio]=trans_cost(y2,y22)

t1=0;
t2=0;
for i=1:length(y2)-1
    if (((y2(i)>0) && (y2(i+1)<0)) || ((y2(i)<0) && (y2(i+1)>0)))
        t1=t1+1;
    end
end

for i=1:length(y22)-1
    if (((y22(i)>0) && (y22(i+1)<0)) || ((y22(i)<0) && (y22(i+1)>0)))
        t2=t2+1;
    end
end

ratio=t2/t1;

end