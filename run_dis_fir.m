%Mohneesh Patel
%MS Electrical Engineering
%Columbia University
%Digital Signal Processing Project


%Calculates the variance and CP 
%of difference and surrogate signal of MA and MP momentum filter


clear all
close all
clc

%loading the data
M=csvread('data.csv');
M=M';
x00=M(1+100:end-0);
d1=diff(x00);
d1=[0 d1];


%No of fft points
N=1024;

%No of sample points,L1
L1=10;

%List of variables
dif=[];
j=1;
c_f1=[];

for L2=20:10:80
    
    i=L2-L1;
    k=0.54*pi/i;
    dif=[dif i];
    c_f1=[c_f1 k];
    
    h0=mov_av(L1);
    h1=mov_av(L2);
    h_mam=mom_fil(L1,L2,h0,h1);
    
    h00=new_fil(L1,N);
    h11=new_fil(L2,N);
    h_nfm=mom_fil(L1,L2,h00,h11);
    
    y_mam=real(filter(h_mam,1,d1));
    yf_mam(j,:)=y_mam;
    y_nfm=real(filter(h_nfm,1,d1));
    yf_nfm(j,:)=y_nfm;
    
    sigma(j)=var(y_mam);
    sigma1(j)=var(y_nfm);
    sigma2(j)=var(d1);
       
    
    j=j+1;
end

for i=1:length(dif)
    h=yf_mam(i,:);
    L=dif(i);
    figure
    plot(d1(1:100),'LineWidth',1.2);
    hold on
    plot(h(1:100),'r');
    grid on
    xlabel('No. of samples');
    ylabel('Amplitude');
    title(['Comparison of ROA and Output Signal for L=',num2str(L+10)]);
    legend('ROA Signal','Output Signal-MACD');
    % To increase font size
 figureHandle = gcf;
% make all text in the figure to size 14 and bold
set(findall(figureHandle,'type','text'),'fontSize',14)%only labels and title
 set(gca,'FontSize',14)%only numbers
 

end

for i=1:length(dif)
    h=yf_nfm(i,:);
    L=dif(i);
    figure
    plot(d1(1:100),'LineWidth',1.2);
    hold on
    plot(h(1:100),'r','LineWidth',1.2);
    grid on
    xlabel('No. of samples');
    ylabel('Amplitude');
    title(['Comparison of ROA and Output Signal for L=',num2str(L+10)]);
    legend('ROA Signal','Output Signal-Minimum Phase');
    % To increase font size
 figureHandle = gcf;
% make all text in the figure to size 14 and bold
set(findall(figureHandle,'type','text'),'fontSize',14)%only labels and title
 set(gca,'FontSize',14)%only numbers
 

end



%% TRANSACTION COST

t_d1=[];
t_s1=[];
t_d2=[];
t_s2=[];
ratio=[];
ratio1=[];


for i=1:length(dif)
    [t1, t2, r]=trans_cost(d1,yf_mam(i,:));
    [t3, t4, r1]=trans_cost(d1,yf_nfm(i,:));
    t_d1=[t_d1 t1];
    t_s1=[t_s1 t2];
    t_d2=[t_d2 t3];
    t_s2=[t_s2 t4];
    ratio=[ratio r];
    ratio1=[ratio1 r1];
end
    


