
load imperfect_sol

disp('-----------------Test for a given deviation from s_rss --------------------')

gamma=0.00011

disp('-------States----------')
s=rule.s_rss';
s(1)=s(1)*gamma;
disp(model.states);
disp(s);

disp('----------Controls---------')
disp(model.controls);
x=funeval(rule.coeff,rule.cdef,s);
disp(x)

disp('-----------Auxiliaries------------')
inu_rat=strmatch('nu_rat',model.auxiliaries,'exact');
inu_strat=strmatch('nu_strat',model.auxiliaries,'exact');
disp(model.auxiliaries);
aux=model.a(s,x,model.params);
disp(aux)
regime=aux(:,inu_rat)<aux(:,inu_strat)




disp('-----------------Test on the hole grid --------------------')
inu_rat=strmatch('nu_rat',model.auxiliaries,'exact');
inu_strat=strmatch('nu_strat',model.auxiliaries,'exact');

aux=model.a(grid.grid,rule.x,model.params);

diff_rat=abs(aux(:,inu_rat)-rule.x(:,4));
diff_strat=abs(aux(:,inu_strat)-rule.x(:,4));
regime_relative=diff_rat<diff_strat;
regime_diff=diff_rat-diff_strat;
mean(regime_relative);
