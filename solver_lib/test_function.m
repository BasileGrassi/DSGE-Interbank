
%% Plot steady-state error function
disp('Plot steady-state error function')

nu=[0:0.1:10];
k=[0:0.1:10];

dist=dist_genpareto3p;

z=zeros(length(k),length(nu));
for i=1:length(nu);
    for j=1:length(k);
    z(j,i)=sum((fun_nu_def([nu(i),k(j)],dist, dist.params, model.params)).^2);
    end;
end;

mesh(nu,k,z);