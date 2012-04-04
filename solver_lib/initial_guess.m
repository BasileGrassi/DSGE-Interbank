function [C] = initial_guess(model, s_ss, x_ss)
    % initial_guess: computes first order controls
    %
    % given a model structure, computes a first order approximation
    % of the controls 

    params = model.params;
    
    n_shocks = 3; % this should be recovered from the model !

    epsilons_0 = zeros(1,n_shocks);

    [S,S_s,S_x] = model.g( s_ss', x_ss', epsilons_0, params);

    [F,F_s, F_x, F_S, F_X] = model.f( s_ss', x_ss', s_ss', x_ss', params );
    
    S_s = squeeze(S_s);
    S_x = squeeze(S_x);
    F_s = squeeze(F_s);
    F_x = squeeze(F_x);
    F_S = squeeze(F_S);
    F_X = squeeze(F_X);

    n_s = size(S_s,2);
    n_x = size(S_x,2);

    M = [ [ eye(n_s), zeros(n_s,n_x)];
          [ -F_S , -F_X] ];
    N = [ [ S_s, S_x ];
          [ F_s, F_x ] ];

    TOL = 0.00001;
    [S,T,Q,Z] = qz(M,N);
    u = diag(S);
    v = diag(T);
    all_eigvals = v ./ u;
                       
    [sortval,sortindex] = sort(abs(all_eigvals));
    stake = sortval(n_s) + TOL;
                              
    [S,T,Q,Z] = qzdiv(stake,S,T,Q,Z);
    Z11 = Z(1:n_s,1:n_s);
    Z12 = Z(1:n_s,n_s+1:end);
    Z21 = Z(n_s+1:end,1:n_s);
    Z22 = Z(n_s+1:end,n_s+1:end);
    S11 = S(1:n_s,1:n_s);
    T11 = T(1:n_s,1:n_s);

    C = Z11' \ Z21';
    C = C';
end