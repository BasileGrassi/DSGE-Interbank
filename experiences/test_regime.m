
load imperfect_sol

dessine='oui';

disp('-----------------Test for a given deviation from s_rss --------------------')

gamma=0.8
disp('-------States----------')
s=rule.s_rss';
s(2)=s(2)*gamma;
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
irat=strmatch('rat',model.auxiliaries,'exact');
iperfect=strmatch('perfect',model.auxiliaries,'exact');
ipro_B=strmatch('pro_B',model.auxiliaries,'exact');
ipro_def=strmatch('pro_def',model.auxiliaries,'exact');
inu_def=strmatch('nu_def',model.controls,'exact');
%disp(model.auxiliaries);
aux=model.a(s,x,model.params);
%disp(aux)
nu_rat=aux(:,inu_rat)
nu_strat=aux(:,inu_strat)
nu_star=aux(:,inu_star)
nu_def=x(:,inu_def)
rat=aux(:,irat)
perfect=aux(:,iperfect)
diffpro=aux(:,ipro_B)-aux(:,ipro_def)






disp('-----------------Test on the hole grid --------------------')
inu_rat=strmatch('nu_rat',model.auxiliaries,'exact');
inu_strat=strmatch('nu_strat',model.auxiliaries,'exact');
inu_rat=strmatch('nu_rat',model.auxiliaries,'exact');
inu_strat=strmatch('nu_strat',model.auxiliaries,'exact');
inu_star=strmatch('nu_star',model.auxiliaries,'exact');
irat=strmatch('rat',model.auxiliaries,'exact');
iperfect=strmatch('perfect',model.auxiliaries,'exact');
ipro_B=strmatch('pro_B',model.auxiliaries,'exact');
ipro_def=strmatch('pro_def',model.auxiliaries,'exact');

aux=model.a(grid.grid,rule.x,model.params);

meanperfect=mean(aux(:,iperfect))
meanrat=mean(aux(:,irat))

ivartheta=strmatch('vartheta',model.parameters,'exact');


disp('-----------------Plot the regime-------------------------')

switch dessine
    case 'oui'

close all
k=[1:0.1:47];
m=[0.5:0.1:4];

nk=length(k);
nm=length(m);

ns=length(model.states);
nx=length(model.controls);
naux=length(model.auxiliaries);

ix_ss=strmatch('x_ss',model.parameters,'exact');

s=zeros(nm*nk,ns);
x=zeros(nx,nm,nk);
aux=zeros(naux,nm,nk);
for i=1:nk;
    for j=1:nm;
        x(:,j,i)=funeval(rule.coeff,rule.cdef,[k(i),m(j),(1+model.params(4))*m(j),0,0]);
        a=model.a([k(i),m(j),(1+model.params(ix_ss))*m(j),0,0], x(:,j,i)',model.params);
        aux(:,j,i)=a';
    end;
end;

z=squeeze(aux(iperfect,:,:));
%z=squeeze(aux(ipro_B,:,:)-aux(ipro_def,:,:));
mesh(k,m,z);
xlabel('k');
ylabel('mm');


    case 'non'
end;


