function  F = step_residuals_nodiff( s, x, e0, w, params, model, coeff, cdef, hom)
% step_residuals_endo : computes arbitrage conditions
% 
% e0 : non-discrete shocks except of the crisis
% w  : weights of non-discrete shocks
    

    f=model.f;
    g=model.g;
    aux=model.a;

    % index of crisis probability variable

    nobs = size(s,1);   % number of points in grid
    n_s = size(s,2);    % number of state-variables
    n_x = size(x,2);    % number of controls
    n_r = n_x;          % number of arbitrage conditions
    
    n_e0 = size(e0,1);        % number of non-discrete shocks
    %n_crisis = 2;             % number of states for discrete shock
    n_e  = n_e0;   % number of shocks
    

    % construct all shocks
    e = e0;
    
    % probabilities are defined as an auxiliary variable 
%     i_prob=strmatch('Pi', model.auxiliaries);
%     [a] = aux(s, x, params);
%     PI = a(:,i_prob);

    
    %PI = PI*hom + 0.02*(1-hom);
%    PI_x = PI_x*0;
    
    % weights used to integrate all shocks  i.e. alpha(s,x) 
    W = ones(nobs,1)*w';



    % we construct the grid and the control for every shock except the crisis one size=nobs*n_e    
    ind   = (1:nobs);
    ind   = ind(ones(1,n_e),:);
    ss    = s(ind,:);   % each observation in ss and xx
    xx    = x(ind,:);   % is repeated n_e times
    ee    = e(repmat(1:n_e,1,nobs),:);
    
  
    % future states (non integrated)
    [SS] = g(ss, xx, ee, params);
    
    % future controls
    XX = funeval(coeff, cdef, SS);
        
    % residuals of arbitrage conditions (non integrated)
    [FF] = f(ss, xx, SS, XX, params);

    FF = reshape(FF, n_e, nobs, n_r);
    FF = permute( FF, [1, 3, 2]);  % order -> ( n_e, n_r, nobs)

    % integrate w.r.t future shocks
    F = zeros( nobs, n_r );
    for n = 1:nobs
        F(n,:) = W(n,:) * FF(:,:,n);
    end
    
end