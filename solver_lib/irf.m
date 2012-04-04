function RES = irf(exo, paramirf, grid, rule, model)
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

%% Output description
% 
% RES.s= the IRF for state variables
% RES.x= the IRF for controls variables
% RES.aux= the IRF for auxiliaries variables



%% The Impulse Response Function


g=model.g;
a=model.a;


N=exo.T;
e=exo.e;

coeff=rule.coeff;
cdef=rule.cdef;

n_s=size(model.states,2);
n_x=size(model.controls,2);
n_aux=size(model.auxiliaries,2);

s=zeros(N,n_s);
x=zeros(N,n_x);
aux=zeros(N,n_aux);


params=model.params;
s_ss=model.s_ss;
x_ss=model.x_ss;
aux_ss=a(s_ss',x_ss',params);

for t=1:N;
    if t==1; 
        s(1,:)=g(s_ss',x_ss',e(1,:),params);
        M = funeval(coeff, cdef, s(1,:));
        x(1,:)=M(:,:,1);
        aux(1,:)=a(s(1,:),x(1,:),params);
    else
        s(t,:)=g(s(t-1,:),x(t-1,:),e(t,:),params);
        M = funeval(coeff, cdef, s(t,:));
        x(t,:)=M(:,:,1);
        aux(t,:)=a(s(t,:),x(t,:),params);
    end;
end;

RES.s=s;
RES.x=x;
RES.aux=aux;





%% Conputing deviation from steady state, diff with steady state

%Compute the percentage deviation from steady-state
s_ssv=ones(N,1)*(s_ss');
x_ssv=ones(N,1)*(x_ss');
aux_ssv=ones(N,1)*(aux_ss);

dev_s=(s-s_ssv)./(s_ssv);
dev_x=(x-x_ssv)./(x_ssv);
dev_aux=(aux-aux_ssv)./(aux_ssv);

RES.dev_s=dev_s;
RES.dev_x=dev_x;
RES.dev_aux=dev_aux;

%Compute the difference with steady-state
diff_s=(s-s_ssv);
diff_x=(x-x_ssv);
diff_aux=(aux-aux_ssv);

RES.diff_s=diff_s;
RES.diff_x=diff_x;
RES.diff_aux=diff_aux;



%% Plotting the IRF
range=paramirf.range;

nsubfig=n_s+n_x+n_aux;
nfig=floor(nsubfig/9);
if rem(nsubfig,9)==0; 
else nfig=nfig+1; 
end;

ifig=1;
for i=1:nsubfig

    if rem(i,10)==0; ifig=ifig+1; end;
   
    figure(ifig);
    hold on;
    
    
    if 1<=i && i<=n_s;
       if sum(strcmp(model.states(i),paramirf.namepercent))>0;
        if rem(i,9)==0; r=9; else r=rem(i,9);end;
        isubplot=330+r;
        subplot(isubplot);
        plot(diff_s(:,i),paramirf.style,'LineWidth',paramirf.width);
        hold on;
        title(model.states(i));
        ylabel('Percent');
        xlabel('years');
        xlim(range);
        else
        if rem(i,9)==0; r=9; else r=rem(i,9);end;
        isubplot=330+r;
        subplot(isubplot);
        
        plot(dev_s(:,i),paramirf.style,'LineWidth',paramirf.width);
        hold on;
        title(model.states(i));
        ylabel('dev from Steady State');
        xlabel('years');
        xlim(range);
       end;         
     else if n_s<i && i<=n_s+n_x;
            j=i-n_s;
            if sum(strcmp(model.controls(j),paramirf.namepercent))>0;
                if rem(i,9)==0; r=9; else r=rem(i,9);end;
                isubplot=330+r;
                subplot(isubplot);
                plot(diff_x(:,j),paramirf.style,'LineWidth',paramirf.width);
                hold on;
                title(model.controls(j));
                ylabel('Percent');
                xlabel('years');
                xlim(range);
            else
                if rem(i,9)==0; r=9; else r=rem(i,9);end;
                isubplot=330+r;
                subplot(isubplot);
                plot(dev_x(:,j),paramirf.style,'LineWidth',paramirf.width);
                hold on;
                title(model.controls(j));
                ylabel('dev from Steady State');
                xlabel('years');
                xlim(range);
            end;
         else
             j=i-n_s-n_x;
             if sum(strcmp(model.auxiliaries(j),paramirf.namepercent))>0;
                if rem(i,9)==0; r=9; else r=rem(i,9);end;
                isubplot=330+r;
                subplot(isubplot)
                plot(diff_aux(:,j),paramirf.style,'LineWidth',paramirf.width);
                hold on;
                title(model.auxiliaries(j));
                ylabel('Percent');
                xlabel('years');
                xlim(range);
             else
                if rem(i,9)==0; r=9; else r=rem(i,9);end;
                isubplot=330+r;
                subplot(isubplot)
                j=i-n_s-n_x;
                plot(dev_aux(:,j),paramirf.style,'LineWidth',paramirf.width);
                hold on;
                title(model.auxiliaries(j));
                ylabel('dev from Steady State');
                xlabel('years');
                xlim(range);
            end;
    end; 
         
end;




end