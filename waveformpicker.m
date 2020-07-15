function waveformpicker
clc
close all

finder='data';

file_name1='TDS_2014C(CH1).txt';
file1=importdata(file_name1);
yloc1=find(strcmp(finder,file1.textdata)==1,1);
data1=str2double(file1.textdata(yloc1+1:end));

file_name2='TDS_2014C(CH2).txt';
file2=importdata(file_name2);
yloc2=find(strcmp(finder,file2.textdata)==1,1);
data2=str2double(file2.textdata(yloc2+1:end));

file_name3='TDS_2014C(CH3).txt';
file3=importdata(file_name3);
yloc3=find(strcmp(finder,file3.textdata)==1,1);
data3=str2double(file3.textdata(yloc3+1:end));

file_name4='TDS_2014C(CH4)_Mean.txt';
file4=importdata(file_name4, ' ',8);
% yloc4=find(strcmp(finder2,file4)==1,1,'last');
data4=str2double(file4(end));
disp(strcat('Potentiometer measure: ', num2str(data4)));

len1=length(data1);
len2=length(data2);
len3=length(data3);

if len1 ~= len2 || len1~=len3
    disp('Lengths of acquired waveforms are not equal');
end

wave_time=(linspace(0, 250*10^-9,len1))';
xax=zeros(len1,1);
figure(1)
plot(wave_time,data2,'g');
hold on
plot(wave_time,data3,'m');
hold on
legend ('CH2 (S-wave)','CH3 (S-wave)');
axis tight
plot(wave_time,data1,'b')
plot(wave_time,xax,'k','LineWidth',2);
hold on

figure(1);

ready0=input('Ready to Pick Limits (1)? ');
disp('Enter y limits for picking');
[~,amp0]=ginput(2);
cutoff1=zeros(len1,1);
cutoff2=zeros(len1,1);
cutoff1(:)=amp0(1);
cutoff2(:)=amp0(2);

plot(wave_time,cutoff1,'y.');
plot(wave_time,cutoff2,'y.');
plot(wave_time,data1,'b')
hold on

figure(1);
zoom on

%Figure 1 TT picking
ready=input('Ready to Pick (1)?');
[t_time1,~]=ginput(1);
disp(strcat('Trigger time: ', num2str(t_time1(1)))); 
zoom on
ready=input('Ready to Pick (1)?');
[a_time1,~]=ginput(1);
disp(strcat('Arrival time: ', num2str(a_time1(1)))); 
tt1=a_time1(1)-t_time1(1);
disp(strcat('projected TT: ',num2str(tt1)));

%Figure 2 TT picking
figure(2);
plot(wave_time,cutoff1,'y.');
hold on
plot(wave_time,cutoff2,'y.');
hold on
plot(wave_time,data1,'b');
plot(wave_time,xax,'k','LineWidth',2);
hold on
axis tight

zoom on

ready2=input('Ready to Pick (1)?');
[t_time2,~]=ginput(1);
disp(strcat('P-wave Trigger time: ', num2str(t_time2(1)))); 
zoom on
ready=input('Ready to Pick (1)?');
[a_time2,~]=ginput(1);
disp(strcat('P-wave Arrival time: ', num2str(a_time2(1)))); 

t_trigger=t_time2(1);
t_arrival=a_time2(1);

tt2=t_arrival-t_trigger;

% init_len=input('Enter Initial length of sample (mm): ');

% pot_len=data4;

% curr_len=init_len-pot_len;

% velocity=curr_len/tt;

% disp(strcat('Current Length of Sample: ',num2str(curr_len)));
disp(strcat('P-wave Travel Time: ',num2str(tt2)));
% disp(strcat('Velocity (Vp): ',num2str(velocity)));

keyboard
end
