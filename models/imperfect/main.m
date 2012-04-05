%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Need a model written as:
%
% snext=G(s,x,e)
% E F(s,x,e,snext,xnext)=0
%
% Do not forget to add the compecon libraries
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Addpath libraries

addpath('../../solver_lib')

%% set model name
model_name = 'imperfect';

%% Parameters
none=[];


model = feval( [model_name '_model']);


%[x_ss,s_ss]=steady_state(model);
%model.x_ss=x_ss';
%model.s_ss=s_ss';

% Define shocks
N_shocks = [5 5];

isigma_z=strmatch('sigma_z',model.parameters, 'exact');
sigma_z=model.params(isigma_z);

isigma_u=strmatch('sigma_u',model.parameters, 'exact');
sigma_u=model.params(isigma_u);

sig = diag( [sigma_z^2 sigma_u^2] );
m = [0 0];
[e,w] = qnwnorm(N_shocks,m,sig);

%% Define the grid
ss = model.s_ss;

smin = [  11, -5.8,-5.8, -0.03, -0.03 ];
smax = [ 14, 6.3, 6.3, 0.03, 0.03 ];
         
orders = [5, 5, 5, 2, 2];


%% Define interpolator

cdef=fundefn('lin', orders, smin, smax);
nodes = funnode(cdef);
grid = gridmake(nodes);

ns = size(grid,1);


%% Convergence criteria
tol=1e-10;
maxiteration=5000;

% Initialization using first order d.r.
x_ss = model.x_ss;
s_ss = model.s_ss;
% X_s = model.X{2}
% xinit=x_ss*ones(1,ns)+X_s*(grid'-s_ss*ones(1,ns));
% x=xinit';
X_s=initial_guess(model, model.s_ss, model.x_ss);
X_s=real(X_s);
xinit=x_ss*ones(1,ns)+X_s*(grid'-s_ss*ones(1,ns));
x=xinit';


iteration=1;
converge=0;

hom_n = 4;
homvec = linspace(0,1,hom_n);
hom_i = 1;
hom = 0;
err0 = 1e6;

disp('Starting policy rule iteration.');
disp('_________________________________________________________');
disp('iter       error        gain    hom   inner    elap.(s)  ');
disp('_________________________________________________________');

tic;
t0 = tic;
%[coeff,B]=funfitxy(cdef, grid, x);
while converge==0 && iteration < maxiteration
    
    [coeff,B]=funfitxy(cdef, grid, x);
    
    fobj = @(xt) step_residuals_nodiff(grid, xt, e, w, model.params, model, coeff, cdef, hom);
    [x_up, nit] = newton_solver_diff(fobj, x, 50);
    
    err=sum(sum(abs(x-x_up)));
    if (err < tol);
        converge=1;
    end;
    
    t1 = tic;
    elapsed = double(t1 - t0)/1e6;
    t0 = t1;
    
    gain=err/err0;
    fprintf('%d\t%e\t%.2f\t%.2f\t%d\t%.2f\n', iteration, err, gain, hom, nit, elapsed)

    
    if (err < 1) && (hom_i < hom_n);
        hom_i = hom_i + 1;
        hom = homvec(hom_i);
    end;
    
    err0 = err;  
    
    x=x_up;
    iteration = iteration+1;
    
    
end;
disp('___________ ________________________________');
toc;

if iteration > maxiteration
    disp('The model could not be solved');
end

%% Save the grid
grille.smax= smax;
grille.smin=smin;
grille.orders=orders;
grille.nodes=nodes;
grille.grid=grid;
grille.ns=ns;

grid=grille;


%% Save the rule
rule.x=x;
rule.cdef=cdef;
rule.coeff=coeff;


save([model_name '_sol'],'model','grid','rule');
