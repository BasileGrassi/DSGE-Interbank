


paramirf.namepercent={'R', 'PI'};


%%%Scenario configuration

close all
clear all


addpath('../solver_lib')

%% Load the model and the decision rule
%this was compute using iterative_main
%contains model, grid and rule
model_name = 'nolabor_log';

addpath(['../models/', model_name])

load nolabor_log_sol;

%% Configure the exogenous fundalmentals
exo.n=2;
N=16;
exo.T=N;
paramirf.namepercent={'R', 'PI', 'theta','u','z'}; %give the name of variable which you want differenc from steady state

%% Baseline
%Define exogeneous path
e_z=zeros(N,1);
e_u=[1; zeros(N-1,1)];

exo.e=[e_z,e_u];

%The shape of irf's benchmarks
T=16;
paramirf.range=[1 T];
paramirf.style='-b';
paramirf.width=2;

%Compute and Plot IRF
RES_baseline=irf(exo, paramirf, grid, rule, model);


%% Linear Decision Rule



%The shape of irf's benchmarks
paramirf.range=[1 N];
paramirf.style='--r';
paramirf.width=2;

ns=grid.ns;
x_ss = model.x_ss;
s_ss = model.s_ss;
X_s = model.X{2};
x=x_ss*ones(1,ns)+X_s*(grid.grid'-s_ss*ones(1,ns));
x=x';

[coeff_lin,B]=funfitxy(rule.cdef, grid.grid, x);


rule_dr1.x=x;
rule_dr1.coeff=coeff_lin;
rule_dr1.cdef=rule.cdef;


%Compute and Plot IRF
RES_dr1=irf_ordre1(exo, paramirf, grid, rule, model);
