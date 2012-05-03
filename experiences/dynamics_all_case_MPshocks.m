


%%%Scenario configuration

close all
clear all

addpath('../solver_lib')

%% Load the model and the decision rule
%this was compute using iterative_main
%contains model, grid and rule


%% Configure the exogenous fundalmentals
exo.n=2;
N=70;
exo.T=N;
paramirf.namepercent={'R','RL', 'PI', 'x','u','z','rk'}; %give the name of variable which you want differenc from steady state


%% Define exogeneous path
e_z=zeros(N,1);
e_u=[0.0089; zeros(N-1,1)];
%e_u=zeros(N,1);

exo.e=[e_z,e_u];

%% Perfect
model_name = 'perfect';

addpath(['../models/', model_name])

load perfect_sol;

T=20;
paramirf.range=[1 T];
paramirf.style='-k';
paramirf.width=2;


%Compute and Plot IRF
RES_perfect=irf_risky_ss(exo, paramirf, grid, rule, model);

%% Imperfect non rationing
model_name = 'imperfect_non_rat';

addpath(['../models/', model_name])

load imperfect_non_rat_sol;

%The shape of irf's benchmarks
T=20;
paramirf.range=[1 T];
paramirf.style='-b';
paramirf.width=2;


%Compute and Plot IRF
RES_imperfect_non_rat=irf_risky_ss(exo, paramirf, grid, rule, model);


%% Imperfect Rationning
model_name = 'imperfect_rat';

addpath(['../models/', model_name])

load imperfect_rat_sol;

%The shape of irf's benchmarks
paramirf.range=[1 T];
paramirf.style='--r';
paramirf.width=2;

%Compute and Plot IRF
RES_imperfect_rat=irf_risky_ss(exo, paramirf, grid, rule, model);


%% Plot what I want
close all


style_perfect='-ks';
style_imperfect_non_rat='-b^';
style_imperfect_rat='-ro';
epaisseur=2.5;
range=[1 T];

% nu_def, y
figure(1)
    subplot(121);
    plot(100*RES_perfect.dev_x(:,4),style_perfect,'LineWidth',epaisseur);
    hold on;
    title(model.controls(4),'FontSize',15,'FontWeight','bold');
    ylabel('Percent Deviation','FontSize',15,'FontWeight','bold');
    xlabel('Quarters','FontSize',15,'FontWeight','bold');
    xlim(range);

    subplot(122);
    plot(100*RES_perfect.dev_aux(:,4),style_perfect,'LineWidth',epaisseur);
    hold on;
    title(model.auxiliaries(4),'FontSize',15,'FontWeight','bold');
    ylabel('Percent Deviation','FontSize',15,'FontWeight','bold');
    xlabel('Quarters','FontSize',15,'FontWeight','bold');
    xlim(range);

figure(1)
    subplot(121);
    plot(100*RES_imperfect_non_rat.dev_x(:,4),style_imperfect_non_rat,'LineWidth',epaisseur);
    hold on;
    title(model.controls(4),'FontSize',15,'FontWeight','bold');
    ylabel('Percent Deviation','FontSize',15,'FontWeight','bold');
    xlabel('Quarters','FontSize',15,'FontWeight','bold');
    xlim(range);

    subplot(122);
    plot(100*RES_imperfect_non_rat.dev_aux(:,4),style_imperfect_non_rat,'LineWidth',epaisseur);
    hold on;
    title(model.auxiliaries(4),'FontSize',15,'FontWeight','bold');
    ylabel('Percent Deviation','FontSize',15,'FontWeight','bold');
    xlabel('Quarters','FontSize',15,'FontWeight','bold');
    xlim(range);

figure(1)
    subplot(121);
    plot(100*RES_imperfect_rat.dev_x(:,4),style_imperfect_rat,'LineWidth',epaisseur);
    hold on;
    title(model.controls(4),'FontSize',15,'FontWeight','bold');
    ylabel('Percent Deviation','FontSize',15,'FontWeight','bold');
    xlabel('Quarters','FontSize',15,'FontWeight','bold');
    xlim(range);

    subplot(122);
    plot(100*RES_imperfect_rat.dev_aux(:,4),style_imperfect_rat,'LineWidth',epaisseur);
    hold on;
    title(model.auxiliaries(4),'FontSize',15,'FontWeight','bold');
    ylabel('Percent Deviation','FontSize',15,'FontWeight','bold');
    xlabel('Quarters','FontSize',15,'FontWeight','bold');
    xlim(range);
        
% k, d
figure(2)
    subplot(121);
    plot(100*RES_perfect.dev_s(:,1),style_perfect,'LineWidth',epaisseur);
    hold on;
    title(model.states(1),'FontSize',15,'FontWeight','bold');
    ylabel('Percent Deviation','FontSize',15,'FontWeight','bold');
    xlabel('Quarters','FontSize',15,'FontWeight','bold');
    xlim(range);

    subplot(122);
    plot(100*RES_perfect.dev_aux(:,11),style_perfect,'LineWidth',epaisseur);
    hold on;
    title(model.auxiliaries(11),'FontSize',15,'FontWeight','bold');
    ylabel('Percent Deviation','FontSize',15,'FontWeight','bold');
    xlabel('Quarters','FontSize',15,'FontWeight','bold');
    xlim(range);


figure(2)
    subplot(121);
    plot(100*RES_imperfect_non_rat.dev_s(:,1),style_imperfect_non_rat,'LineWidth',epaisseur);
    hold on;
    title(model.states(1),'FontSize',15,'FontWeight','bold');
    ylabel('Percent Deviation','FontSize',15,'FontWeight','bold');
    xlabel('Quarters','FontSize',15,'FontWeight','bold');
    xlim(range);

    subplot(122);
    plot(100*RES_imperfect_non_rat.dev_aux(:,11),style_imperfect_non_rat,'LineWidth',epaisseur);
    hold on;
    title(model.auxiliaries(11),'FontSize',15,'FontWeight','bold');
    ylabel('Percent Deviation','FontSize',15,'FontWeight','bold');
    xlabel('Quarters','FontSize',15,'FontWeight','bold');
    xlim(range);

figure(2)
    subplot(121);
    plot(100*RES_imperfect_rat.dev_s(:,1),style_imperfect_rat,'LineWidth',epaisseur);
    hold on;
    title(model.states(1),'FontSize',15,'FontWeight','bold');
    ylabel('Percent Deviation','FontSize',15,'FontWeight','bold');
    xlabel('Quarters','FontSize',15,'FontWeight','bold');
    xlim(range);

    subplot(122);
    plot(100*RES_imperfect_rat.dev_aux(:,11),style_imperfect_rat,'LineWidth',epaisseur);
    hold on;
    title(model.auxiliaries(11),'FontSize',15,'FontWeight','bold');
    ylabel('Percent Deviation','FontSize',15,'FontWeight','bold');
    xlabel('Quarters','FontSize',15,'FontWeight','bold');
    xlim(range);



%R, PI

figure(3)
    subplot(121);
    plot(RES_perfect.diff_x(:,1),style_perfect,'LineWidth',epaisseur);
    hold on;
    title(model.controls(1),'FontSize',15,'FontWeight','bold');
    ylabel('Deviation','FontSize',15,'FontWeight','bold');
    xlabel('Quarters','FontSize',15,'FontWeight','bold');
    xlim(range);

    subplot(122);
    plot(RES_perfect.diff_x(:,2),style_perfect,'LineWidth',epaisseur);
    hold on;
    title(model.controls(2),'FontSize',15,'FontWeight','bold');
    ylabel('Deviation','FontSize',15,'FontWeight','bold');
    xlabel('Quarters','FontSize',15,'FontWeight','bold');
    xlim(range);

figure(3)
    subplot(121);
    plot(RES_imperfect_non_rat.diff_x(:,1),style_imperfect_non_rat,'LineWidth',epaisseur);
    hold on;
    title(model.controls(1),'FontSize',15,'FontWeight','bold');
    ylabel('Deviation','FontSize',15,'FontWeight','bold');
    xlabel('Quarters','FontSize',15,'FontWeight','bold');
    xlim(range);

    subplot(122);
    plot(RES_imperfect_non_rat.diff_x(:,2),style_imperfect_non_rat,'LineWidth',epaisseur);
    hold on;
    title(model.controls(2),'FontSize',15,'FontWeight','bold');
    ylabel('Deviation','FontSize',15,'FontWeight','bold');
    xlabel('Quarters','FontSize',15,'FontWeight','bold');
    xlim(range);
    
figure(3)
    subplot(121);
    plot(RES_imperfect_rat.diff_x(:,1),style_imperfect_rat,'LineWidth',epaisseur);
    hold on;
    title(model.controls(1),'FontSize',15,'FontWeight','bold');
    ylabel('Deviation','FontSize',15,'FontWeight','bold');
    xlabel('Quarters','FontSize',15,'FontWeight','bold');
    xlim(range);

    subplot(122);
    plot(RES_imperfect_rat.diff_x(:,2),style_imperfect_rat,'LineWidth',epaisseur);
    hold on;
    title(model.controls(2),'FontSize',15,'FontWeight','bold');
    ylabel('Deviation','FontSize',15,'FontWeight','bold');
    xlabel('Quarters','FontSize',15,'FontWeight','bold');
    xlim(range);
%Spread


figure(4)

    plot(0*(RES_perfect.diff_x(:,3)-RES_imperfect_rat.diff_x(:,1)),style_perfect,'LineWidth',epaisseur);
    hold on;
    title('R^L-R','FontSize',15,'FontWeight','bold');
    ylabel('bps deviation','FontSize',15,'FontWeight','bold');
    xlabel('Quarters','FontSize',15,'FontWeight','bold');
    xlim(range);

    plot(100*(RES_imperfect_non_rat.diff_x(:,3)-RES_imperfect_rat.diff_x(:,1)),style_imperfect_non_rat,'LineWidth',epaisseur);
    hold on;
    title('R^L-R','FontSize',15,'FontWeight','bold');
    ylabel('bps deviation','FontSize',15,'FontWeight','bold');
    xlabel('Quarters','FontSize',15,'FontWeight','bold');
    xlim(range);

    plot(100*(RES_imperfect_rat.diff_x(:,3)-RES_imperfect_rat.diff_x(:,1)),style_imperfect_rat,'LineWidth',epaisseur);
    hold on;
    title('RL-R','FontSize',15,'FontWeight','bold');
    ylabel('bps deviation','FontSize',15,'FontWeight','bold');
    xlabel('Quarters','FontSize',15,'FontWeight','bold');
    xlim(range);

%% Inputs 'struture description of irf

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
