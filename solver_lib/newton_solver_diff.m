function [x, it] = newton_solver_diff(fun, x0, maxit, diff)

    N = size(x0,1);
    n_x = size(x0,2);
        
       
    tol = 1e-8;
    eps = 1e-5;

    
    err = 1;
    
    if nargin < 3
        maxit = 10;
    end

    it = 0;
    
    while err > tol && it < maxit
        
        res = fun(x0);
        
        N = size(res,1);
        n_x = size(res,2);
        
        % compute numerical gradient
        jac = zeros(N, n_x, n_x);
        for i = 1:n_x
            xx = x0;
            xx(:,i) = xx(:,i) + eps;
            dres = (fun(xx) - res)/eps;
            jac(:,:,i) = dres;
        end
        
        jac = permute(jac,[2,3,1]);
        dx = zeros( size( x0 ) );
        for i = 1:N
            mat = jac(:,:,i);
            dx(i,:) = mat \ res(i,:)';
        end
        x = x0 - dx;
                
        err = abs(max(max(res)));
        it = it + 1;
        x0 = x;
    end
        
end
