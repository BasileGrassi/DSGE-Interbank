function [ RES] = fun_nu_def(var,dist,distparams, params)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

nu_def=var(1);
k=var(2);

beta=params(1);
alpha=params(2);
delta=params(3);
x_ss=params(4);
theta=params(5);

R=(1+x_ss)/(beta);
RL=R;


z=0;

Phi=dist.cdf(nu_def,distparams);

rk=1/(beta*Phi)+delta-1;


%from (10)
mu= Phi^(1/(theta-1))*(theta-1)/theta;

%from (8)
w=mu*(1-alpha)*exp(z)*k^alpha;

%from (6)
y=exp(z)*Phi^(theta/(theta-1)+alpha-1)*k^alpha;

%from (10bis)
pro=1/(theta-1)*(theta/(theta-1))^(-theta)*(mu)^(1-theta)*y;

%from (11)
%RES(1) = nu_def-exp(z)*(pro)/(w*RL);
RES(1)=nu_def-exp(z)*(pro-RL*k)/(w*RL);
RES(2) = rk-mu*alpha*k^(alpha-1);



end

