function [ RES] = fun_nu_def(var,vartheta,dist,distparams, parameters, params,pri)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

nu_def=var(1);
k=var(2);
RL=var(3);
d=var(4);

%fundamental parameters
ibeta=strmatch('beta',parameters);
ialpha=strmatch('alpha',parameters);
idelta=strmatch('delta',parameters);
ix_ss=strmatch('x_ss',parameters);
itheta=strmatch('theta',parameters);


beta=params(ibeta);
alpha=params(ialpha);
delta=params(idelta);
x_ss=params(ix_ss);
x=x_ss;
theta=params(itheta);

%Imperfect information parameters
ivartheta=strmatch('vartheta',parameters);
%vartheta=params(ivartheta);


R=(1+x_ss)/(beta);



z=0;

%fraction of defaulters
Phi=dist.cdf(nu_def,distparams);

%
Enu_def=dist.Etr(nu_def,distparams);

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
nu_star = (pro-RL*k)/(RL*w);

if pri==1;
    %cas 1
    if nu_rat>nu_strat && nu_strat > nu_star; 
        disp('nu_rat>nu_strat > nu_star!');
        disp('nu_def=nu_star');
    %cas 2
    elseif nu_rat>nu_star && nu_star > nu_strat; 
        disp('nu_rat>nu_star > nu_strat; !'); 
        disp('nu_def=nu_strat');
    %cas 3
    elseif nu_strat>nu_star && nu_star > nu_rat;
        disp('nu_strat>nu_star > nu_rat');
        disp('nu_def=nu_rat');
    %cas 4    
    elseif nu_star>nu_strat && nu_strat > nu_rat;
        disp('nu_star>nu_strat > nu_rat');
        disp('nu_def=nu_rat');
    %cas 5    
    elseif nu_strat>nu_rat && nu_rat > nu_star;
        disp('nu_strat>nu_rat > nu_star');
        disp('nu_def=nu_star');
    %cas 6    
    elseif nu_star>nu_rat && nu_rat > nu_strat;
        disp('nu_star>nu_rat > nu_strat');
        disp('nu_def=nu_strat');
    else disp('tu as oublie un cas mon gars');
    end;
end;

RES(1) = nu_def-min([nu_star,nu_rat , nu_strat],[],2); %RES(1) = nu_def - nu_strat;
RES(2) = rk-mu*alpha*k^(alpha-1);
RES(3) = Phi*(RL-R)-(1-Phi)*vartheta*(R-1)/RL;
RES(4)= d-(Enu_def*w/exp(z)*Phi-(1-Phi)*(k+x)/RL-Phi*x)/(Phi-(1-Phi)*(R-1)/RL); %RES(4) = Phi*(d+x)+(1-Phi)*lhat-Phi*Enu_def*w;

end

