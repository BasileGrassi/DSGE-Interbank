function RES = RES_steady(X,model)
   
    n_x=length(model.controls);
    n_s=length(model.states);
    x_ss=X(1:n_x);
    s_ss=X(n_x+1:n_s+n_x);
    
    g=model.g;
    f=model.f;
           
    RES=zeros(1,n_x+n_s);
    RES(n_x+1:n_s+n_x)=s_ss-g(s_ss,x_ss,[0,0],model.params);
    RES(1:n_x)=f(s_ss,x_ss,s_ss,x_ss,model.params);

end