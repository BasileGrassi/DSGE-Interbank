clear all;

model=baseline_model;

%Parameters
beta= model.params(1);
delta=model.params(3);


%Fixed cost Distribution parameters
dist=dist_genpareto3p;

%% Match a value of quartely spread between 1+rk and 1/beta
disp('--------------Match---------------')

options=optimset('display','final');

spreadq=0.0095 %spread at the quaterly frequency 4% annualy
match=1/(beta*spreadq+1) %Valu of Phi to match

%Using me
% disp('--------------Match Using me---------------')
% fun= @(x) fun_nu_def_match([x(1) x(2)],dist,[ x(3), dist.params(2:3)] ,match, model.params);
% [x,Fval,exitflag]=fsolve(fun,[1,1,0],options);
% 
% nu_def=x(1)
% k=x(2)
% me=x(3)
% 
% Phi=dist.cdf(nu_def,[ x(3), dist.params(2:3)]);

%Using sigma
disp('--------------Match Using sigma---------------')
fun= @(x) fun_nu_def_match([x(1) x(2)],dist,[dist.params(1), x(3), dist.params(3)] ,match, model.params);
[x,Fval,exitflag]=fsolve(fun,[1,1,1],options);

nu_def=x(1)
k=x(2)
sigma=x(3)

Phi=dist.cdf(nu_def,[dist.params(1), x(3), dist.params(3)]);

%Using xi
% disp('--------------Match Using xi---------------')
% fun= @(x) fun_nu_def_match([x(1) x(2)],dist,[dist.params(1:2), x(3)] ,match, model.params);
% [x,Fval,exitflag]=fsolve(fun,[10,10,0.9],options);
% 
% nu_def=x(1)
% k=x(2)
% xi=x(3)
% 
% Phi=dist.cdf(nu_def,[dist.params(1:2), x(3)]);



%% Numerical Solving of the Steady State
disp('--------------Solve---------------')

options=optimset('display','final');

dist.params(2)=sigma;

nu_def=2;
k=1;

fun= @(x) fun_nu_def(x,dist,dist.params,model.params);
[x,Fval,exitflag]=fsolve(fun,[nu_def,k],options);

nu_def=x(1)
k=x(2)

Phi=dist.cdf(nu_def,dist.params)

