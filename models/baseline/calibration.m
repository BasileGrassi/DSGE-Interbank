
model=baseline_model;

%Parameters
beta= model.params(1);
delta=model.params(3);


%Fixed cost Distribution parameters
sigma = -1;

disp('--------------Match---------------')
%Match a value of quartely spread between 1+rk and 1/beta using me
options=optimset('display','iter');

spreadq=0.0095; %spread at the quaterly frequency 4% annualy
match=1/(beta*(spreadq+delta)+1);


fun= @(x) fun_nu_def_match([x],sigma,match, model.params);
[x,Fval,exitflag]=fsolve(fun,[-1,1.2,1],options);

nu_def=x(1)
k=x(2)
me=x(3)

Phi=1-exp(-(nu_def-me)/sigma)

disp('--------------Solve---------------')
%Numerical Solving
options=optimset('display','iter');


fun= @(x) fun_nu_def(x,me,sigma, model.params);
[x,Fval,exitflag]=fsolve(fun,[nu_def,k],options);

nu_def=x(1)
k=x(2)

Phi=1-exp(-(nu_def-me)/sigma)

