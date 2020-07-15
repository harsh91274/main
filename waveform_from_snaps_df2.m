%P wave setting
%1 = P wave
%2 = S1 wave
%3 = Trigger
%4 = Potentiometer

%S1 wave setting
%1 = P wave
%2 = S1 wave
%3 = Trigger
%4 = S2 wave

%S1 wave setting
%1 = P wave
%2 = S1 wave
%3 = Trigger
%4 = S2 wave

function waveform_from_snaps_df2
clc
clear all
close all

prefix=input('Enter prefix to files: ','s');

file_name1=strcat(prefix,' - ',' TDS 2014C(CH1).txt');
file_name2=strcat(prefix,' - ',' TDS 2014C(CH2).txt');
file_name3=strcat(prefix,' - ',' TDS 2014C(CH3).txt');
file_name4=strcat(prefix,' - ',' TDS 2014C(CH4).txt');

% file1=importdata(file_name1);
% file2=importdata(file_name2);
% file3=importdata(file_name3);
% file4=importdata(file_name4);

file1=importdata(file_name1,'\t',22);
file2=importdata(file_name2,'\t',22);
file3=importdata(file_name3,'\t',22);
file4=importdata(file_name4,'\t',22);

data1=file1.data;
data2=file2.data;
data3=file3.data;
data4=file4.data;

disp('1. P wave');
disp('2. S1 wave');
disp('3. S2 wave');

choice=input('Enter Choice: ');

tt1=2*10^-7;
tt2=2*10^-7;

if choice==1    
    med1=median(data1(:,2));
    len1=length(data1(:,2));
    xax=zeros(len1,1);
    xax(:)=med1;
    
    lmax=max(data3(:,2));
    lmin=min(data3(:,2));
    
    trig_mat=[lmin lmax];
    arr_mat=[lmin lmax];
    
    %%
    figure(1)
    ha(1)=subplot(2,1,1);
    plot(data1(:,1),data1(:,2));
    hold on
    plot(data2(:,1),data2(:,2),'r');
    hold on
    plot(data3(:,1),data3(:,2),'g');
    hold on
    plot(data1(:,1),xax,'k','LineWidth',2);
    hold on
    xlabel('time');ylabel('Volts');
    axis tight
    legend('P-wave','S-wave','Trigger');
    hold on
    ha(2)=subplot(2,1,2);
    plot(data3(:,1),data3(:,2),'g');
    hold on
    plot(data1(:,1),xax,'k','LineWidth',2);
    hold on
    xlabel('time');ylabel('Volts');
    axis tight
    legend('Trigger');
    hold on
    
    linkaxes(ha, 'x');
%     set(gcf,'units','normalized','outerposition',[0 0 1 1])
    
%     zoom on
%     buff=input('Ready to pick trigger time(1) ? : ');
%     zoom off
%     [tt1,~]=ginput(1);
%     disp(strcat('Trigger Time: ',num2str(tt1),' s'));
    %%
    xinit_mat=[tt1 tt1];
    
    figure(2)
    plot(data3(:,1),data3(:,2),'g');
    hold on
    plot(data1(:,1),data1(:,2));
    hold on
    plot(data1(:,1),xax,'k','LineWidth',2);
    hold on
    plot(xinit_mat,trig_mat,'c');
    hold on
    xlabel('time');ylabel('Volts');
    axis tight
    legend('P-wave','Trigger');
    hold on
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    
%     zoom on
%     buff=input('Ready to pick trigger time(1) ? : ');
%     zoom off
%     [tt2,~]=ginput(1);
%     disp(strcat('Trigger Time: ',num2str(tt2),' s'));
    
    zoom on
    buff=input('Ready to pick arrival time time(1) ? : ');
    zoom off
    [at2,~]=ginput(1);
    disp(strcat('Arrival Time: ',num2str(at2),' s'));
    travel_time2=at2-tt2;
    disp(strcat('Projected Travel Time: ',num2str(travel_time2),' s'));
    
    x1_mat=[tt2 tt2];
    x2_mat=[at2 at2];
    %%
    figure(3)
    plot(data1(:,1),xax,'k','LineWidth',2);
    hold on
    plot(data1(:,1),data1(:,2));
    hold on
    plot(x1_mat,trig_mat,'c');
    hold on
    plot(x2_mat,arr_mat,'c');
    hold on
    xlabel('time');ylabel('Volts');
    axis tight
    hold on
    
    zoom on
    buff=input('Ready to pick arrival time time(1) ? : ');
    zoom off
    [at3,~]=ginput(1);
    disp(strcat('Arrival Time: ',num2str(at3),' s'));
    travel_time3=at3-tt2;
    disp(strcat('Travel Time: ',num2str(travel_time3),' s'));
    
    x1_mat2=[tt2 tt2];
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

elseif choice==2  
    med2=median(data2(:,2));
    len2=length(data2(:,2));
    xax=zeros(len2,1);
    xax(:)=med2;
    
    lmax=max(data3(:,2));
    lmin=min(data3(:,2));
    
    trig_mat=[lmin lmax];
    arr_mat=[lmin lmax];
    
    %%
    figure(1)
    ha(1)=subplot(2,1,1);
    plot(data1(:,1),data1(:,2));
    hold on
    plot(data2(:,1),data2(:,2),'r');
    hold on
    plot(data3(:,1),data3(:,2),'g');
    hold on
    plot(data4(:,1),data4(:,2),'m');
    hold on
    plot(data2(:,1),xax,'k','LineWidth',2);
    hold on
    xlabel('time');ylabel('Volts');
    axis tight
    legend('P-wave','S1-wave','Trigger','S2-wave');
    hold on
    ha(2)=subplot(2,1,2);
    plot(data3(:,1),data3(:,2),'g');
    hold on
    plot(data2(:,1),xax,'k','LineWidth',2);
    hold on
    xlabel('time');ylabel('Volts');
    axis tight
    legend('Trigger');
    hold on
    
    linkaxes(ha, 'x');
%     set(gcf,'units','normalized','outerposition',[0 0 1 1])
%     zoom on
%     buff=input('Ready to pick trigger time(1) ? : ');
%     zoom off
%     [tt1,~]=ginput(1);
%     disp(strcat('Trigger Time: ',num2str(tt1),' s'));
    %%
    xinit_mat=[tt1 tt1];
    
    figure(2)
    ha(1)=subplot(2,1,1);
    plot(data3(:,1),data3(:,2),'g');
    hold on
    plot(data2(:,1),data2(:,2),'r');
    hold on
    plot(data2(:,1),xax,'k','LineWidth',2);
    hold on
    plot(xinit_mat,trig_mat,'c');
    hold on
    xlabel('time');ylabel('Volts');
    axis tight
    legend('Trigger','S1-wave');
    hold on
    
    ha(2)=subplot(2,1,2);
    plot(data3(:,1),data3(:,2),'g');
    hold on
    plot(data4(:,1),data4(:,2),'m');
    hold on
    plot(data4(:,1),xax,'k','LineWidth',2);
    hold on
    plot(xinit_mat,trig_mat,'c');
    hold on
    xlabel('time');ylabel('Volts');
    axis tight
    legend('Trigger','S2-wave from S1');
    hold on
    
    linkaxes(ha, 'x');
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    
%     zoom on
%     buff=input('Ready to pick trigger time(1) ? : ');
%     zoom off
%     [tt2,~]=ginput(1);
%     disp(strcat('Trigger Time: ',num2str(tt2),' s'));
%     
    zoom on
    buff=input('Ready to pick arrival time time(1) ? : ');
    zoom off
    [at2,~]=ginput(1);
    disp(strcat('Arrival Time: ',num2str(at2),' s'));
    travel_time2=at2-tt2;
    disp(strcat('Projected Travel Time: ',num2str(travel_time2),' s'));
    
    x1_mat=[tt2 tt2];
    x2_mat=[at2 at2];
    %%
    figure(3)
    plot(data2(:,1),xax,'k','LineWidth',2);
    hold on
    plot(data2(:,1),data2(:,2),'r');
    hold on
    plot(x1_mat,trig_mat,'c');
    hold on
    plot(x2_mat,arr_mat,'c');
    hold on
    xlabel('time');ylabel('Volts');
    axis tight
    hold on
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    
    zoom on
    buff=input('Ready to pick arrival time time(1) ? : ');
    zoom off
    [at3,~]=ginput(1);
    disp(strcat('Arrival Time: ',num2str(at3),' s'));
    travel_time3=at3-tt2;
    disp(strcat('Travel Time: ',num2str(travel_time3),' s'));
    
    x1_mat2=[tt2 tt2];
    x2_mat2=[at3 at3];
    %%
    figure(4);
    plot(data2(:,1),data2(:,2),'r');
    hold on
    plot(data2(:,1),xax,'k','LineWidth',2);
    hold on
    plot(x1_mat2,trig_mat,'c');
    hold on
    plot(x2_mat2,arr_mat,'c');
    hold on
    axis tight
    title(strcat('S1-wave Travel Time: ',num2str(travel_time3)));
    hold on
    saveas(gcf,'S1_wave_interp.jpg');
    
elseif choice==3  
    med4=median(data4(:,2));
    len4=length(data4(:,2));
    xax=zeros(len4,1);
    xax(:)=med4;
    
    lmax=max(data3(:,2));
    lmin=min(data3(:,2));
    
    trig_mat=[lmin lmax];
    arr_mat=[lmin lmax];
    
    %%
    figure(1)
    ha(1)=subplot(2,1,1);
    plot(data1(:,1),data1(:,2));
    hold on
    plot(data2(:,1),data2(:,2),'r');
    hold on
    plot(data3(:,1),data3(:,2),'g');
    hold on
    plot(data4(:,1),data4(:,2),'m');
    hold on
    plot(data2(:,1),xax,'k','LineWidth',2);
    hold on
    xlabel('time');ylabel('Volts');
    axis tight
    legend('P-wave','S1-wave','Trigger','S2-wave');
    hold on
    ha(2)=subplot(2,1,2);
    plot(data3(:,1),data3(:,2),'g');
    hold on
    plot(data2(:,1),xax,'k','LineWidth',2);
    hold on
    xlabel('time');ylabel('Volts');
    axis tight
    legend('Trigger');
    hold on
    
    linkaxes(ha, 'x');
%     zoom on
%     buff=input('Ready to pick trigger time(1) ? : ');
%     zoom off
%     [tt1,~]=ginput(1);
%     disp(strcat('Trigger Time: ',num2str(tt1),' s'));
    %%
    xinit_mat=[tt1 tt1];
    
    figure(2)
    ha(1)=subplot(2,1,1);
    plot(data3(:,1),data3(:,2),'g');
    hold on
    plot(data4(:,1),data4(:,2),'m');
    hold on
    plot(data4(:,1),xax,'k','LineWidth',2);
    hold on
    plot(xinit_mat,trig_mat,'c');
    hold on
    xlabel('time');ylabel('Volts');
    axis tight
    legend('S2-wave','Trigger');
    hold on
    
    ha(2)=subplot(2,1,2);
    plot(data3(:,1),data3(:,2),'g');
    hold on
    plot(data2(:,1),data2(:,2),'r');
    hold on
    plot(data2(:,1),xax,'k','LineWidth',2);
    hold on
    plot(xinit_mat,trig_mat,'c');
    hold on
    xlabel('time');ylabel('Volts');
    axis tight
    legend('Trigger','S1-wave from S2');
    hold on
    
    linkaxes(ha, 'x');
    set(gcf,'units','normalized','outerposition',[0 0 1 1]);
    
%     zoom on
%     buff=input('Ready to pick trigger time(1) ? : ');
%     zoom off
%     [tt2,~]=ginput(1);
%     disp(strcat('Trigger Time: ',num2str(tt2),' s'));
    
    zoom on
    buff=input('Ready to pick arrival time time(1) ? : ');
    zoom off
    [at2,~]=ginput(1);
    disp(strcat('Arrival Time: ',num2str(at2),' s'));
    travel_time2=at2-tt2;
    disp(strcat('Projected Travel Time: ',num2str(travel_time2),' s'));
    
    x1_mat=[tt2 tt2];
    x2_mat=[at2 at2];
    %%
    figure(3)
    plot(data4(:,1),xax,'k','LineWidth',2);
    hold on
    plot(data4(:,1),data4(:,2),'m');
    hold on
    plot(x1_mat,trig_mat,'c');
    hold on
    plot(x2_mat,arr_mat,'c');
    hold on
    xlabel('time');ylabel('Volts');
    axis tight
    hold on
    set(gcf,'units','normalized','outerposition',[0 0 1 1]);
    
    zoom on
    buff=input('Ready to pick arrival time time(1) ? : ');
    zoom off
    [at3,~]=ginput(1);
    disp(strcat('Arrival Time: ',num2str(at3),' s'));
    travel_time3=at3-tt2;
    disp(strcat('Travel Time: ',num2str(travel_time3),' s'));
    
    x1_mat2=[tt2 tt2];
    x2_mat2=[at3 at3];
    %%
    figure(4);
    plot(data4(:,1),data4(:,2),'m');
    hold on
    plot(data4(:,1),xax,'k','LineWidth',2);
    hold on
    plot(x1_mat2,trig_mat,'c');
    hold on
    plot(x2_mat2,arr_mat,'c');
    hold on
    axis tight
    title(strcat('S2-wave Travel Time: ',num2str(travel_time3)));
    hold on
    saveas(gcf,'S2_wave_interp.jpg');
end

keyboard
end
