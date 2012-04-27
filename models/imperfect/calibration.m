
clear all;
close all

addpath('../../solver_lib')

model=imperfect_model;


%% How steady-state value depend upon vartheta
disp('--------------Plot Result as a function of vartheta---------------')

options=optimset('display','off','MaxFunEvals',50000,'MaxIter',50000);

dist=dist_genpareto3p;


varinit=[-9.2846, 12.7096, 1.0238, -7.9165];

vartheta=[0.8];
nvartheta=length(vartheta);
ivartheta=strmatch('vartheta',model.parameters,'exact');

iperfect=strmatch('perfect',model.auxiliaries,'exact');

sigma=[5.6:0.1:7.6];
isigma=strmatch('sigma',model.parameters,'exact');
nsigma=length(sigma);



x=zeros(nsigma,length(model.controls));
s=zeros(nsigma,length(model.states));
aux=zeros(nsigma,length(model.auxiliaries));


for i=1:nsigma;
    disp('For sigma=')
    disp(sigma(i));

    params=model.params;
    params(ivartheta)=0.8;
    params(isigma)=sigma(i);

    [s_ss,x_ss]=steady_state(model,params);
    x(i,:)=x_ss;
    s(i,:)=s_ss;
    
    
 
    aux_ss=model.a(s_ss,x_ss,params);
    aux(i,:)=aux_ss;
    
    disp('In the interbank market')
    if aux_ss(iperfect)==1; disp('Perfect case'); else disp('Imperfect case'); end;
    disp('----------------------------------------------------------------')

end


ibeta=strmatch('beta',model.parameters);
ix_ss=strmatch('x_ss',model.parameters);
beta=model.params(ibeta);
x_ss=model.params(ix_ss);

R=(1+x_ss)/(beta);

figure(1)
subplot(331)
plot(vartheta,x(:,1));
ylabel('R');
xlabel('vartheta');

subplot(332)
plot(vartheta,x(:,2));
ylabel('PI');
xlabel('vartheta');

subplot(333)
plot(vartheta,x(:,3)-R);
ylabel('Spread RL-R');
xlabel('vartheta');

subplot(334)
plot(vartheta,x(:,4));
ylabel('nu_def');
xlabel('vartheta');

subplot(335)
plot(vartheta,x(:,5));
ylabel('d');
xlabel('vartheta');


subplot(336)
plot(vartheta,aux(:,iperfect));
ylabel('perfect');
xlabel('vartheta');

subplot(337)
plot(vartheta,s(:,1));
ylabel('k');
xlabel('vartheta');

subplot(338)
plot(vartheta,aux(:,1));
ylabel('Phi');
xlabel('vartheta');

%En fonction de sigma
figure(2)
subplot(331)
plot(sigma,x(:,1));
ylabel('R');
xlabel('vartheta');

subplot(332)
plot(sigma,x(:,2));
ylabel('PI');
xlabel('vartheta');

subplot(333)
plot(sigma,x(:,3)-R);
ylabel('Spread RL-R');
xlabel('vartheta');

subplot(334)
plot(sigma,x(:,4));
ylabel('nu_def');
xlabel('vartheta');

subplot(335)
plot(sigma,x(:,5));
ylabel('d');
xlabel('vartheta');


subplot(336)
plot(sigma,aux(:,iperfect));
ylabel('perfect');
xlabel('vartheta');

subplot(337)
plot(sigma,s(:,1));
ylabel('k');
xlabel('vartheta');

subplot(338)
plot(sigma,aux(:,1));
ylabel('Phi');
xlabel('vartheta');
% 
% subplot(339)
% plot(sigma,aux(:,19)-aux(:,18));
% ylabel('nu_star-nu_strat');
% xlabel('vartheta');

subplot(339)
plot(sigma,aux(:,20)-aux(:,21));
ylabel('pro_B-pro_def');
xlabel('vartheta');

%% Solve for a value of theta
% disp('--------------Solve for a value of vartheta---------------')
% 
% vartheta=0.5;
% 
% fun= @(var) fun_nu_def(var,vartheta,dist,dist.params, model.parameters, model.params,0);
% [x_sol,Fval,exitflag] = fsolve(fun,varinit,options);
% disp(exitflag);
% 
% 
% nu_def=x_sol(1)
% k=x_sol(2)
% RL=x_sol(3)
% d=x_sol(4)
%     
% fun_nu_def([nu_def k RL d],vartheta,dist,dist.params, model.parameters, model.params,1);

% nu_def=x(1)
% k=x(2)
% RL=x(3)
% d=x(4)
% 
% Phi=dist.cdf(nu_def,dist.params);
% 
% fun_nu_def([nu_def k RL d],dist,dist.params, model.parameters, model.params,1);