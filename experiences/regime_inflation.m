
addpath('../models/imperfect_low_inflation');
addpath('../models/imperfect_medium_inflation');
addpath('../models/imperfect_high_inflation');

close all

%% Low inflation
%x_ss=0.005 soit 2% annually in steady-state
clear all

load imperfect_low_inflation_sol



k=[1:0.1:47];
m=[0.5:0.1:4];

nk=length(k);
nm=length(m);

ns=length(model.states);
nx=length(model.controls);
naux=length(model.auxiliaries);

ix_ss=strmatch('x_ss',model.parameters,'exact');
iperfect=strmatch('perfect',model.auxiliaries,'exact');

s=zeros(nm*nk,ns);
x=zeros(nx,nm,nk);
aux=zeros(naux,nm,nk);

for i=1:nk;
    for j=1:nm;
        x(:,j,i)=funeval(rule.coeff,rule.cdef,[k(i),m(j),(1+model.params(ix_ss))*m(j),0,0]);
        a=model.a([k(i),m(j),(1+model.params(ix_ss))*m(j),0,0], x(:,j,i)',model.params);
        aux(:,j,i)=a';
    end;
end;

z=squeeze(aux(iperfect,:,:));
mean_low_inflation= mean(mean(z))
disp(model.s_ss')
disp(rule.s_rss')

figure(1);
mesh(k,m,z);
xlabel('k'); xlim([min(k) max(k)]);
ylabel('mm'); ylim([min(m) max(m)]);
title('Low inflation : 2% per year')

%% Medium inflation
%x_ss=0.0125 soit 5% annually in steady-state
clear all
load imperfect_medium_inflation_sol


k=[1:0.1:47];
m=[0.5:0.1:4];

nk=length(k);
nm=length(m);

ns=length(model.states);
nx=length(model.controls);
naux=length(model.auxiliaries);

ix_ss=strmatch('x_ss',model.parameters,'exact');
iperfect=strmatch('perfect',model.auxiliaries,'exact');

s=zeros(nm*nk,ns);
x=zeros(nx,nm,nk);
aux=zeros(naux,nm,nk);

for i=1:nk;
    for j=1:nm;
        x(:,j,i)=funeval(rule.coeff,rule.cdef,[k(i),m(j),(1+model.params(ix_ss))*m(j),0,0]);
        a=model.a([k(i),m(j),(1+model.params(ix_ss))*m(j),0,0], x(:,j,i)',model.params);
        aux(:,j,i)=a';
    end;
end;

z=squeeze(aux(iperfect,:,:));
mean_medium_inflation= mean(mean(z))
disp(model.s_ss')
disp(rule.s_rss')

figure(2);
mesh(k,m,z);
xlabel('k'); xlim([min(k) max(k)]);
ylabel('mm'); ylim([min(m) max(m)]);
title('Medium inflation : 5% per year')

%% High inlfation
%x_ss=0.025 soit 10% annually in steady-state

clear all
load imperfect_high_inflation_sol



k=[1:0.1:47];
m=[0.5:0.1:4];

nk=length(k);
nm=length(m);

ns=length(model.states);
nx=length(model.controls);
naux=length(model.auxiliaries);

ix_ss=strmatch('x_ss',model.parameters,'exact');
iperfect=strmatch('perfect',model.auxiliaries,'exact');

s=zeros(nm*nk,ns);
x=zeros(nx,nm,nk);
aux=zeros(naux,nm,nk);

for i=1:nk;
    for j=1:nm;
        x(:,j,i)=funeval(rule.coeff,rule.cdef,[k(i),m(j),(1+model.params(ix_ss))*m(j),0,0]);
        a=model.a([k(i),m(j),(1+model.params(ix_ss))*m(j),0,0], x(:,j,i)',model.params);
        aux(:,j,i)=a';
    end;
end;

z=squeeze(aux(iperfect,:,:));
mean_high_inflation= mean(mean(z))
disp(model.s_ss')
disp(rule.s_rss')

figure(3);
mesh(k,m,z);
xlabel('k'); xlim([min(k) max(k)]);
ylabel('mm'); ylim([min(m) max(m)]);
title('High inflation : 10% per year')
