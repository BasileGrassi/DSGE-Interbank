function [dist] = get_dist()
    dist = dist_info;
    dist.cdf = @cdf;
    dist.pdf = @pdf;
    dist.Etr = @Etr;
    
end

function out1 = cdf(x,params)
    out1=1-exp(-(x-params(1))/params(2));
    
end

function out1 = pdf(x,params)
    out1=1/params(2)*exp(-(x-params(1))/params(2));
    
end



function out1 = Etr(x,params)
    out1 = params(1)+params(2)-(x+params(2))*exp(-(nu_def-params(1))/params(2));
end

function [out1] = dist_info() % informations about the model

    di = struct;
    di.parameters = { 'me','sigma'};
    di.params = [ -12.8813 1 ];
    di.support=[-12.8813 10];
    out1 = di;

end