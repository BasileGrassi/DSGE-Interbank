clear all
model=imperfect_model;

isigma=strmatch('sigma',model.parameters,'exact');
ixi=strmatch('xi',model.parameters,'exact');
ime=strmatch('me',model.parameters,'exact');
ibeta=strmatch('beta',model.parameters,'exact');
ixss=strmatch('x_ss',model.parameters,'exact');
ivartheta=strmatch('vartheta',model.parameters,'exact');
ibig=strmatch('big',model.parameters,'exact');

params=model.params;


params(isigma)=0.2;
params(ixi)=0.9;
params(ime)=-30;

params(ibeta)=0.9925; %0.99
params(ixss)=0.025; %0.005

params(ivartheta)=0.9;

params(ibig)=5;

[s_ss,x_ss]=steady_state(model,params);
model.x_ss=x_ss';
model.s_ss=s_ss';
model.aux=model.a(s_ss,x_ss,params);

Phi=model.aux(1)
diffpro=model.aux(20)-model.aux(21)
k=model.s_ss(1)
ratio=diffpro/k
nu_def=model.x_ss(4)
d=model.x_ss(5)
mm=model.s_ss(2)
k/mm


X_s=initial_guess(model, model.s_ss, model.x_ss,params)


