                          clc;clear;
N=81;k=1;
Uin=200; %输入电压为200V
dI=zeros(1,N); %电感电流纹波
dU=zeros(1,N); %电容电压纹波
Uout=zeros(1,N); %输出电压
G=zeros(1,N); % 电压增益
% 取100组数据来计算峰峰值，得出纹波
iL_period=zeros(1,100);uC_period=zeros(1,100);
tic %计时模块
for D=0.01:1:80.01
    out=sim('m1',[0,0.11]);
    for i=1:100
        iL_period(i)=out.iL.Data(1000000+i,1);
        uC_period(i)=out.uC.Data(1000000+i,1);
    end
    dI(k)=(max(iL_period)-min(iL_period));
    dU(k)=(max(uC_period)-min(uC_period));
    Uout(k)=out.Uo.Data(end);
    G(k)=Uout(k)/Uin;
    fprintf('循环第%d轮\n',k);
    k=k+1;
end
toc
N=81;
g=1;
d2=0.0001;
dIcal=zeros(1,N); %电感电流纹波理论值
dUcal=zeros(1,N); %电容电压纹波理论值
Gcal=zeros(1,N); % 电压增益
for d1=0.01:1:80.01
    dIcal(g)=200*d2*(1-d2)/400;
    dUcal(g)=200*d2*(1-d2)/16000;
    Gcal(g)=d2;
    g=g+1;
    d2=d2+0.01;
end
%% 数据制图
d=0.01:1:80.01;
figure(1)
dI=1000*dI; %单位为mA
dIcal=1000*dIcal;
plot(d,dI,'b-');
hold on;
plot(d,dIcal,'r-');
legend('Simulation results','Theoretical results')
xlabel('$D/\%$','Interpreter','latex');
ylabel('$\Delta I/ \mathrm{mA}$','Interpreter','latex');
title('$\Delta I=f(D)$','Interpreter','latex');

figure(2)
dU=1000*dU; %单位为mV
dUcal=1000*dUcal;
plot(d,dU,'b-');
hold on;
plot(d,dUcal,'r-');
legend('Simulation results','Theoretical results')
xlabel('$D/\%$','Interpreter','latex');
ylabel('$\Delta U/ \mathrm{mV}$','Interpreter','latex');
title('$\Delta U=f(D)$','Interpreter','latex');

figure(3)
plot(d,G,'b-');
hold on;
plot(d,Gcal,'r-');
legend('Simulation results','Theoretical results')
xlabel('$D/\%$','Interpreter','latex');
ylabel('$G$','Interpreter','latex');
title('$G=f(D)$','Interpreter','latex');