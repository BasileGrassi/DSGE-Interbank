

disp('-----------------Plot the regime-------------------------')



close all
k=[0.1:0.1:47];


nk=length(k);


ns=length(model.states);
nx=length(model.controls);
naux=length(model.auxiliaries);

inu_rat=strmatch('nu_rat',model.auxiliaries,'exact');
inu_strat=strmatch('nu_strat',model.auxiliaries,'exact');
inu_star=strmatch('nu_star',model.auxiliaries,'exact');
irat=strmatch('rat',model.auxiliaries,'exact');
iperfect=strmatch('perfect',model.auxiliaries,'exact');
ipro_B=strmatch('pro_B',model.auxiliaries,'exact');
ipro_def=strmatch('pro_def',model.auxiliaries,'exact');
inu_def=strmatch('nu_def',model.controls,'exact');


s=zeros(nk,ns);
x=zeros(nx,nk);
aux=zeros(naux,nk);
for i=1:nk;
        x(:,i)=funeval(rule.coeff,rule.cdef,[k(i),-3]);
        a=model.a([k(i),0], x(:,i)',model.params);
        aux(:,i)=a';
end;


z=squeeze(aux(iperfect,:));

plot(k,aux(iperfect,:));




disp('-----------------Plot the regime-------------------------')



close all
k=[1:0.1:47];
z=[-3:0.1:3];

nk=length(k);
nz=length(z);

ns=length(model.states);
nx=length(model.controls);
naux=length(model.auxiliaries);



s=zeros(nz*nk,ns);
x=zeros(nx,nz,nk);
aux=zeros(naux,nz,nk);
for i=1:nk;
    for j=1:nz;
        x(:,j,i)=funeval(rule.coeff,rule.cdef,[k(i),z(j)]);
        a=model.a([k(i),z(j)], x(:,j,i)',model.params);
        aux(:,j,i)=a';
    end;
end;

pl=squeeze(aux(iperfect,:,:));
%z=squeeze(aux(ipro_B,:,:)-aux(ipro_def,:,:));
mesh(k,z,pl);
xlabel('k');
ylabel('z');





