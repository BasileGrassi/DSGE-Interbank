function [RES] = fun_nu_def(var,me,sigma, params,pri)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

nu_def=var(1);
k=var(2);
RL=var(3);
d = var(4);

beta=0.989;%params(1);
alpha=0.36;%params(2);
delta= 0.019;%params(3);
x_ss=0.0125;% params(4);
theta=6;% params(5);
vartheta=params(1);

R=(1+x_ss)/(beta);
x=x_ss;


z=0;

%fraction of defaulters
Phi=1-exp(-(nu_def-me)/sigma);

%
Enu_def=me+sigma-(nu_def+sigma)*exp(-(nu_def-me)/sigma);

%return on capital
rk=1/(beta*Phi)+delta-1;


%marginal cost
mu= Phi^(1/(theta-1))*(theta-1)/theta;

%wage
w=mu*(1-alpha)*exp(z)*k^alpha;

%production
y=exp(z)*Phi^(theta/(theta-1)+alpha-1)*k^alpha;

%profit of a project
pro=1/(theta-1)*(theta/(theta-1))^(-theta)*(mu)^(1-theta)*y;

%max amount in interbank market
lhat=(k+x-(R-1)*d)/RL;

%threshold of rationning
nu_rat=(d+x+lhat)/w;
nu_strat=(pro+(RL-R)*d+RL*x-vartheta*lhat)/(RL*w);

if pri==1;
    if nu_def>nu_rat; 
        disp('Rationning!'); 
    else disp('Not Rationning!'); 
    end;
end;

%RES(1) = nu_def-min(nu_rat , nu_strat);
RES(1) = nu_def- nu_strat;
RES(2) = rk-mu*alpha*k^(alpha-1);
RES(3) = Phi*(RL-R)-(1-Phi)*vartheta*(R-1)/RL;
%RES(4) = Phi*(d+x)+(1-Phi)*lhat-Phi*Enu_def*w;
RES(4)= d-(Enu_def*w*Phi-(1-Phi)*(k+x)/RL)/(Phi-(1-Phi)*(R-1)/RL);

end

