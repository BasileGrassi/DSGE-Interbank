function [dist] = get_dist()
    dist = dist_info;
    dist.cdf = @cdf;
    dist.pdf = @pdf;
    dist.Etr = @Etr;
    
end

function out1 = cdf(x,params)
    me=params(1);
    sigma=params(2);
    xi=params(3);
    out1=1-(1+xi.*(x-me)./sigma).^(-1/xi);
    
end

function out1 = pdf(x,params)
    me=params(1);
    sigma=params(2);
    xi=params(3);
    out1=1/sigma*(1+xi.*(x-me)./sigma).^(-1/xi-1);
    
end



function out1 = Etr(x,params)
    me=params(1);
    sigma=params(2);
    xi=params(3);
    Phi=1-(1+xi*(x-me)/sigma).^(-1/xi);
    l=(xi==1)*sigma+(xi<1)*0+(xi>1)*(1/0);
    out1 = sigma+x.*(1+xi.*(x-me)/sigma).^(-1/xi)./Phi; %sigma-l./Phi+x.*(1+xi.*(x-me)/sigma).^(-1/xi)./Phi;
end

function [out1] = dist_info() % informations about the model

    di = struct;
    di.parameters = { 'me','sigma', 'xi'};
    di.params = [ -30 0.2 1.3];    
    di.support=[-30 10];
    out1 = di;

end