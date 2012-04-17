function [s_rss]=risky_steady_state(model,rule)

n_s=length(model.states);
n_e=n_s; %number of shocks, which is < number of states n_s


e_nul=zeros(1,n_e);
g=model.g;

fun=@(s) s-g(s,funeval(rule.coeff, rule.cdef, s),e_nul,model.params);

options=optimset('Display','Iter','MaxFunEvals',5000,'MaxIter',5000);
s_rss=fsolve(fun,model.s_ss',options);



end