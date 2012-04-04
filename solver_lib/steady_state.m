function [x_ss,s_ss]=steady_state(model)

n_x=length(model.controls);
n_s=length(model.states);


options=optimset('Display','Iter','MaxFunEvals',5000,'MaxIter',5000);
fun=@(X) RES_steady(X,model);
X=fsolve(fun,[model.x_ss',model.s_ss'],options);

x_ss=real(X(1:n_x));
s_ss=real(X(n_x+1:n_s+n_x));

end