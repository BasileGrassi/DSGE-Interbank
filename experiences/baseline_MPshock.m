

paramirf.namepercent={'R', 'PI'};


%%%Scenario configuration

close all
clear all

addpath('../solver_lib')

%% Load the model and the decision rule
%this was compute using iterative_main
%contains model, grid and rule
model_name = 'baseline';

addpath(['../models/', model_name])

load baseline_sol;

%% Configure the exogenous fundalmentals
exo.n=2;
N=70;
exo.T=N;
paramirf.namepercent={'R', 'PI', 'theta','u','z','I'}; %give the name of variable which you want differenc from steady state

%% Baseline
%Define exogeneous path
e_z=zeros(N,1);
e_u=[100*0.0089; zeros(N-1,1)];

exo.e=[e_z,e_u];

%The shape of irf's benchmarks
T=16
paramirf.range=[1 T];
paramirf.style='-b';
paramirf.width=2;

%Compute and Plot IRF
%RES_baseline=irf(exo, paramirf, grid, rule, model);


%% Linear Decision Rule


%The shape of irf's benchmarks
paramirf.range=[1 T];
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
RES_dr1=irf_ordre1(exo, paramirf, grid, rule_dr1, model);

%% Inputs 'struture description

%The exogenous shocks
% exo.n= # of exogeneous variables
% exo.e= the exogeneous
% exo.T= size of the exogeneous time serie

%The parameters of the IRF
% paramirf.range= the range of time that will be plot
% paramirf.style= the style of the line (markers, dashed, etc...) e.g: '-bs'
% paramirf.width= the width of the line
% paramirf.namepercent=a cell with the name of variable where you want difference with steady-state rather than percentation deviation from steady state state variable
% paramirf.namelevel=a cell with the name of variable where you want level rather than percentation deviation from steady state state variable

%The grid
% grid.smax=  max of state on each dimension
% grid.smin= min of state on each dimension
% grid.nodes= nodes comming from the associated cdef
% grid.orders= # of points on each dimension
% grid.grid= the grid on a matrix where the rows stand for each points and
% the colums for each state
% grid.ns= the number of points of the grid = size(grid.grid,1) 
% 
% 
%The decision rule
% rule.x= value of the controls on each point of the grid
% rule.cdef= set of function. The interpolante are in this set
% rule.coeff= the coefficient which sum up the interpolate function

%The model
% model.s_ss= steady-state value of the states
% model.x_s=  steady-state value of the controls
