%Name - Mohneesh Patel
%MS Electrical Engineering
%Columbia University
%Digital Signal Processing Project


%Compares the frequency response of moving average & momentum FIR
%filter and plots the graph between cut-off frequency & group
%delay

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
    
    
    fvtool(h_mam,1,h_nfm,1);

    y_mam=real(filter(h_mam,1,d1));
    yf_mam(j,:)=y_mam;
    y_nfm=real(filter(h_nfm,1,d1));
    yf_nfm(j,:)=y_nfm;
    
    [g w]=grpdelay(h_mam,1,N);
    z1=find_fir(w,k);
    g_m=mean(g(2:z1));
    g_mam(j)=g_m;
    
    [g1 w1]=grpdelay(h_nfm,1,N);
    z2=find_fir(w1,k);
    g_mean=mean(g1(2:z2));
    g_nfm(j)=g_mean;
    
    
    j=j+1;
end

figure
plot(c_f1,g_mam,'k','LineWidth',3);
hold on t5
plot(c_f1,g_nfm,'m','LineWidth',3);
grid on
xlabel('Cut-off Freq(rad/samples)');
ylabel('Delay (in samples)');
title('Relation between Cut-off Frequency and Delay');
legend('MACD Filter','Minimum Phase Filter');
% To increase font size
 figureHandle = gcf;
% make all text in the figure to size 14 and bold
set(findall(figureHandle,'type','text'),'fontSize',14)%only labels and title
 set(gca,'FontSize',14)%only numbers