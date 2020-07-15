function waveform_from_snaps
clc
close all

file_name1='TDS 2014C(CH1).txt';
file_name2='TDS 2014C(CH2).txt';
file_name3='TDS 2014C(CH3).txt';

file1=importdata(file_name1);
file2=importdata(file_name2);
file3=importdata(file_name3);

data1=file1.data;
data2=file2.data;
data3=file3.data;

med1=median(data1(:,2));
len1=length(data1(:,2));
xax=zeros(len1,1);
xax(:)=med1;
%%
figure(1)
plot(data1(:,1),data1(:,2));
hold on
plot(data2(:,1),data2(:,2),'r');
hold on
plot(data3(:,1),data3(:,2),'m');
hold on
plot(data1(:,1),xax,'k','LineWidth',2);
hold on
xlabel('time');ylabel('Volts');
axis tight
legend('P-wave','S-wave','Trigger');
hold on

zoom on
buff=input('Ready to pick trigger time(1) ? : ');
zoom off
[tt1,~]=ginput(1);
disp(strcat('Trigger Time: ',num2str(tt1),' s'));
%%
figure(2)
plot(data1(:,1),data1(:,2));
hold on
plot(data2(:,1),data2(:,2),'r');
hold on
plot(data1(:,1),xax,'k','LineWidth',2);
hold on
xlabel('time');ylabel('Volts');
axis tight
legend('P-wave','S-wave');
hold on

zoom on
buff=input('Ready to pick trigger time(1) ? : ');
zoom off
[tt2,~]=ginput(1);
disp(strcat('Trigger Time: ',num2str(tt2),' s'));

zoom on
buff=input('Ready to pick arrival time time(1) ? : ');
zoom off
[at2,~]=ginput(1);
disp(strcat('Arrival Time: ',num2str(at2),' s'));
travel_time2=at2-tt2;
disp(strcat('Projected Travel Time: ',num2str(travel_time2),' s'));

lmax=max(data1(:,2));
lmin=min(data1(:,2));

trig_mat=[lmin lmax];
arr_mat=[lmin lmax];
x1_mat=[tt2 tt2];
x2_mat=[at2 at2];
%%
figure(3)
plot(data1(:,1),data1(:,2));
hold on
plot(data1(:,1),xax,'k','LineWidth',2);
hold on
plot(x1_mat,trig_mat,'c');
hold on
plot(x2_mat,arr_mat,'c');
hold on
xlabel('time');ylabel('Volts');
axis tight
hold on

zoom on
buff=input('Ready to pick trigger time(1) ? : ');
zoom off
[tt3,~]=ginput(1);
disp(strcat('Trigger Time: ',num2str(tt3),' s'));

zoom on
buff=input('Ready to pick arrival time time(1) ? : ');
zoom off
[at3,~]=ginput(1);
disp(strcat('Arrival Time: ',num2str(at3),' s'));
travel_time3=at3-tt3;
disp(strcat('Travel Time: ',num2str(travel_time3),' s'));

x1_mat2=[tt3 tt3];
x2_mat2=[at3 at3];
%%
figure(4);
plot(data1(:,1),data1(:,2),'b');
hold on
plot(data1(:,1),xax,'k','LineWidth',2);
hold on
plot(x1_mat2,trig_mat,'c');
hold on
plot(x2_mat2,arr_mat,'c');
hold on
axis tight
title(strcat('P-wave Travel Time: ',num2str(travel_time3)));
hold on
saveas(gcf,'P_wave_interp.jpg');

keyboard
end
