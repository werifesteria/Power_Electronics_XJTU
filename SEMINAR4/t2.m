clc;clear;
N=46;k=1;
Uin=800; %输入电压为200V
Uout=zeros(1,N); %输出电压
G=zeros(1,N); % 电压增益

%% 模型调用
tic %计时模块
for D=0.01:1:45.01
    out=sim('m2',[0,0.3]);
    Uout(k)=out.Uo.Data(end);
    G(k)=Uout(k)/Uin;
    fprintf('循环第%d轮\n',k);
    k=k+1;
end
toc

load G_CCM.mat
load G_DCM.mat
clf;
%% 数据制图
d=0.01:1:45.01;
figure(1)
plot(d,G_CCM,'b-');
xlabel('$D/\%$','Interpreter','latex');
ylabel('$G$','Interpreter','latex');
title('$G=f(D)$','Interpreter','latex');

figure(2)

d=0.01:1:45.01
plot(d,G_CCM,'b-');
hold on
plot(d,G_DCM,'r-');
xlabel('$D/\%$','Interpreter','latex');
ylabel('$G$','Interpreter','latex');
title('$G=f(D)$','Interpreter','latex');
legend('$G_{CCM}$','$G_{DCM}$','Interpreter','latex');
