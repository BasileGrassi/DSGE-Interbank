clear all;
close all;

%Generalized Pareto with 2 params
dist=dist_genpareto2p;

%Plot cdf
figure(1);
xa=dist.support(1);
xb=dist.support(2);
pas=0.1;
x=[xa:pas:xb];
y=dist.cdf(x,dist.params);
plot(x,y);
hold on;
xlim(dist.support);
title('cdf of the distribution')
%line([-9.2846 , -9.2846],[0 , 1],'Color','r')
dist.cdf(-9.2846,dist.params)

%Plot pdf
figure(2);
xa=dist.support(1);
xb=dist.support(2);
pas=0.1;
x=[xa:pas:xb];
y=dist.pdf(x,dist.params);
plot(x,y);
hold on;
xlim(dist.support);
title('pdf of the distribution')
%line([-9.2846 , -9.2846],[0 , 1],'Color','r')

%Plot Etr
figure(3);
xa=dist.support(1);
xb=dist.support(2);
pas=0.1;
x=[xa:pas:xb];
y=dist.Etr(x,dist.params);
plot(x,y);
hold on;
xlim(dist.support);
title('Expectation tronquee of the distribution')
%line([-9.2846 , -9.2846],[0 , 1],'Color','r')

%% Generalized Pareto with 3 params
dist=dist_genpareto3p;

figure(1);
xa=dist.support(1);
xb=dist.support(2);
pas=0.1;
x=[xa:pas:xb];
y=dist.cdf(x,dist.params);
plot(x,y,'k');
hold on;
xlim(dist.support);
title('cdf of the distribution')
line([-9.2846 , -9.2846],[0 , 1],'Color','r')
dist.cdf(-9.2846,dist.params)

%Plot pdf
figure(2);
xa=dist.support(1);
xb=dist.support(2);
pas=0.1;
x=[xa:pas:xb];
y=dist.pdf(x,dist.params);
plot(x,y,'k');
hold on;
xlim(dist.support);
title('pdf of the distribution')

%Plot Etr
% figure(3);
% xa=dist.support(1);
% xb=dist.support(2);
% pas=0.1;
% x=[xa:pas:xb];
% y=dist.Etr(x,dist.params);
% plot(x,y,'k');
% hold on;
% xlim(dist.support);
% title('Expectation tronquee of the distribution')

