
clear all;
close all

addpath('../../solver_lib')

model=imperfect_model;


%% How steady-state value depend upon vartheta
disp('--------------Plot Result as a function of vartheta---------------')

options=optimset('display','off','MaxFunEvals',50000,'MaxIter',50000);

dist=dist_genpareto3p;


varinit=[-9.2846, 12.7096, 1.0238, -7.9165];

vartheta=[0.1:0.1:1];
nvartheta=length(vartheta);

x=zeros(nvartheta,4);

for i=1:nvartheta;
    disp('For vartheta=')
    disp(vartheta(i));

    fun= @(var) fun_nu_def(var,vartheta(i),dist,dist.params, model.parameters, model.params,0);
    [x_sol,Fval,exitflag] = fsolve(fun,varinit,options);
    disp('exitflag=')
    disp(exitflag);
    x(i,:)=x_sol;
    
    nu_def=x_sol(1);
    k=x_sol(2);
    RL=x_sol(3);
    d=x_sol(4);
    disp('In the interbank market')
    fun_nu_def([nu_def k RL d],vartheta(i),dist,dist.params, model.parameters, model.params,1);
    disp('----------------------------------------------------------------')

end


ibeta=strmatch('beta',model.parameters);
ix_ss=strmatch('x_ss',model.parameters);
beta=model.params(ibeta);
x_ss=model.params(ix_ss);

R=(1+x_ss)/(beta);

figure()
subplot(221)
plot(vartheta,x(:,1));
ylabel('nu_def');
xlabel('vartheta');

subplot(222)
plot(vartheta,x(:,2));
ylabel('k');
xlabel('vartheta');

subplot(223)
plot(vartheta,x(:,3)-R);
%hold;
%plot(vartheta,0.0063+0*vartheta,'r')
ylabel('RL');
xlabel('vartheta');

subplot(224)
plot(vartheta,x(:,4));
ylabel('d');
xlabel('vartheta');


%% Solve for a value of theta
disp('--------------Solve for a value of vartheta---------------')

vartheta=0.5;

fun= @(var) fun_nu_def(var,vartheta,dist,dist.params, model.parameters, model.params,0);
[x_sol,Fval,exitflag] = fsolve(fun,varinit,options);
disp(exitflag);


nu_def=x_sol(1)
k=x_sol(2)
RL=x_sol(3)
d=x_sol(4)
    
fun_nu_def([nu_def k RL d],vartheta,dist,dist.params, model.parameters, model.params,1);

% nu_def=x(1)
% k=x(2)
% RL=x(3)
% d=x(4)
% 
% Phi=dist.cdf(nu_def,dist.params);
% 
% fun_nu_def([nu_def k RL d],dist,dist.params, model.parameters, model.params,1);