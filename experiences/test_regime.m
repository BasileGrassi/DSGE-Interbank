
load imperfect_sol

disp('-----------------Test for a given deviation from s_rss --------------------')

gamma=2
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
inu_star=strmatch('nu_star',model.auxiliaries,'exact');
%disp(model.auxiliaries);
aux=model.a(s,x,model.params);
%disp(aux)
aux(:,inu_rat)
aux(:,inu_strat)
aux(:,inu_star)





disp('-----------------Test on the hole grid --------------------')
inu_rat=strmatch('nu_rat',model.auxiliaries,'exact');
inu_strat=strmatch('nu_strat',model.auxiliaries,'exact');

aux=model.a(grid.grid,rule.x,model.params);

regime_relative=aux(:,inu_strat)<aux(:,inu_star);
regime_diff=aux(:,inu_strat)-aux(:,inu_star);
mean(regime_relative);
[m,i]=min(regime_diff);

ivartheta=strmatch('vartheta',model.parameters,'exact');

PI_B=(rule.x(:,3)-rule.x(:,1)).*aux(:,9)+rule.x(:,3).*aux(:,7)+rule.x(:,3).*grid.grid(:,1);
perfect=PI_B>model.params(ivartheta);
mean(perfect)
