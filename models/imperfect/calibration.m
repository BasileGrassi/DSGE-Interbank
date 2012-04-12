
%model=imperfect_model;

%Parameters
beta= 0.989;%model.params(1);
delta=0.019;%model.params(3);


%Fixed cost Distribution parameters
sigma = -1;

disp('--------------Solve---------------')
%Numerical Solving
options=optimset('display','iter','MaxFunEvals',50000,'MaxIter',50000);

me=-12.8813;
sigma=1;

params=[0.8];

xinit=[-9.2846, 12.7096, 1.0238, -7.9165];

fun= @(x) fun_nu_def(x,me,sigma, params,0);
[x,Fval,exitflag] = fsolve(fun,[-10.2027,22.0739,1.0240,-10.8977],options);

nu_def=x(1)
k=x(2)
RL=x(3)
d=x(4)

Phi=1-exp(-(nu_def-me)/sigma)

fun_nu_def(x,me,sigma, params,1);
