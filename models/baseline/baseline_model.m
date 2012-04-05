function [model] = get_model()
    model = model_info;
    model.f = @f;
    model.g = @g;
    model.a = @a;
end

function [out1,out2,out3,out4,out5] = f(s,x,snext,xnext,p)
    n = size(s,1);

    % f
      out1 = zeros(n,5);
      out1(:,1) = -p(1).*xnext(:,1).*(-exp((p(11) - xnext(:,5))./p(12)) + 1).*(p(2).*snext(:,1).^(p(2) - 1).*(p(5) - 1).*(-exp((p(11) - xnext(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*exp(snext(:,4))./p(5) - p(3) + 1) + x(:,1);
      out1(:,2) = -p(1).*xnext(:,2).*xnext(:,1)./(xnext(:,3) + 1) + x(:,1);
      out1(:,3) = -p(1).*x(:,2)./((xnext(:,3) + 1).*(p(4) - snext(:,1).*exp((p(11) - xnext(:,5))./p(12)) + snext(:,3)./(xnext(:,3) + 1) + snext(:,5) - snext(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - xnext(:,5))./p(12)) + 1).*(-exp((p(11) - xnext(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(p(11) + p(12) - (p(12) + xnext(:,5)).*exp((p(11) - xnext(:,5))./p(12)))./p(5))) + 1./(p(4) - s(:,1).*exp((p(11) - x(:,5))./p(12)) + s(:,3)./(x(:,3) + 1) + s(:,5) - s(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(p(11) + p(12) - (p(12) + x(:,5)).*exp((p(11) - x(:,5))./p(12)))./p(5));
      out1(:,4) = x(:,2) - x(:,4);
      out1(:,5) = -p(5).*s(:,1).^(-p(2)).*(-x(:,4).*s(:,1) + s(:,1).^p(2).*(p(5)./(p(5) - 1)).^(-p(5)).*((p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1))./p(5)).^(-p(5) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(p(2) + p(5)./(p(5) - 1) - 1).*exp(s(:,4))./(p(5) - 1)).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(-1./(p(5) - 1))./(x(:,4).*(-p(2) + 1).*(p(5) - 1)) + x(:,5);

if nargout >= 2

    % df/ds
      out2 = zeros(n,5,5);
      out2(:,1,1) = 0; % d eq_1 w.r.t. k
      out2(:,1,2) = 0; % d eq_1 w.r.t. mm
      out2(:,1,3) = 0; % d eq_1 w.r.t. mL
      out2(:,1,4) = 0; % d eq_1 w.r.t. z
      out2(:,1,5) = 0; % d eq_1 w.r.t. u
      out2(:,2,1) = 0; % d eq_2 w.r.t. k
      out2(:,2,2) = 0; % d eq_2 w.r.t. mm
      out2(:,2,3) = 0; % d eq_2 w.r.t. mL
      out2(:,2,4) = 0; % d eq_2 w.r.t. z
      out2(:,2,5) = 0; % d eq_2 w.r.t. u
      out2(:,3,1) = (p(2).*s(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(p(11) + p(12) - (p(12) + x(:,5)).*exp((p(11) - x(:,5))./p(12)))./(p(5).*s(:,1)) + exp((p(11) - x(:,5))./p(12)))./(p(4) - s(:,1).*exp((p(11) - x(:,5))./p(12)) + s(:,3)./(x(:,3) + 1) + s(:,5) - s(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(p(11) + p(12) - (p(12) + x(:,5)).*exp((p(11) - x(:,5))./p(12)))./p(5)).^2; % d eq_3 w.r.t. k
      out2(:,3,2) = 0; % d eq_3 w.r.t. mm
      out2(:,3,3) = -1./((x(:,3) + 1).*(p(4) - s(:,1).*exp((p(11) - x(:,5))./p(12)) + s(:,3)./(x(:,3) + 1) + s(:,5) - s(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(p(11) + p(12) - (p(12) + x(:,5)).*exp((p(11) - x(:,5))./p(12)))./p(5)).^2); % d eq_3 w.r.t. mL
      out2(:,3,4) = 0; % d eq_3 w.r.t. z
      out2(:,3,5) = -1./(p(4) - s(:,1).*exp((p(11) - x(:,5))./p(12)) + s(:,3)./(x(:,3) + 1) + s(:,5) - s(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(p(11) + p(12) - (p(12) + x(:,5)).*exp((p(11) - x(:,5))./p(12)))./p(5)).^2; % d eq_3 w.r.t. u
      out2(:,4,1) = 0; % d eq_4 w.r.t. k
      out2(:,4,2) = 0; % d eq_4 w.r.t. mm
      out2(:,4,3) = 0; % d eq_4 w.r.t. mL
      out2(:,4,4) = 0; % d eq_4 w.r.t. z
      out2(:,4,5) = 0; % d eq_4 w.r.t. u
      out2(:,5,1) = p(2).*p(5).*s(:,1).^(-p(2)).*(-x(:,4).*s(:,1) + s(:,1).^p(2).*(p(5)./(p(5) - 1)).^(-p(5)).*((p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1))./p(5)).^(-p(5) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(p(2) + p(5)./(p(5) - 1) - 1).*exp(s(:,4))./(p(5) - 1)).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(-1./(p(5) - 1))./(x(:,4).*s(:,1).*(-p(2) + 1).*(p(5) - 1)) - p(5).*s(:,1).^(-p(2)).*(p(2).*s(:,1).^p(2).*(p(5)./(p(5) - 1)).^(-p(5)).*((p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1))./p(5)).^(-p(5) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(p(2) + p(5)./(p(5) - 1) - 1).*exp(s(:,4))./(s(:,1).*(p(5) - 1)) - x(:,4)).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(-1./(p(5) - 1))./(x(:,4).*(-p(2) + 1).*(p(5) - 1)); % d eq_5 w.r.t. k
      out2(:,5,2) = 0; % d eq_5 w.r.t. mm
      out2(:,5,3) = 0; % d eq_5 w.r.t. mL
      out2(:,5,4) = -p(5).*(p(5)./(p(5) - 1)).^(-p(5)).*((p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1))./p(5)).^(-p(5) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(-1./(p(5) - 1)).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(p(2) + p(5)./(p(5) - 1) - 1).*exp(s(:,4))./(x(:,4).*(-p(2) + 1).*(p(5) - 1).^2); % d eq_5 w.r.t. z
      out2(:,5,5) = 0; % d eq_5 w.r.t. u

    % df/dx
      out3 = zeros(n,5,5);
      out3(:,1,1) = 1; % d eq_1 w.r.t. lamb
      out3(:,1,2) = 0; % d eq_1 w.r.t. R
      out3(:,1,3) = 0; % d eq_1 w.r.t. PI
      out3(:,1,4) = 0; % d eq_1 w.r.t. RL
      out3(:,1,5) = 0; % d eq_1 w.r.t. nu_def
      out3(:,2,1) = 1; % d eq_2 w.r.t. lamb
      out3(:,2,2) = 0; % d eq_2 w.r.t. R
      out3(:,2,3) = 0; % d eq_2 w.r.t. PI
      out3(:,2,4) = 0; % d eq_2 w.r.t. RL
      out3(:,2,5) = 0; % d eq_2 w.r.t. nu_def
      out3(:,3,1) = 0; % d eq_3 w.r.t. lamb
      out3(:,3,2) = -p(1)./((xnext(:,3) + 1).*(p(4) - snext(:,1).*exp((p(11) - xnext(:,5))./p(12)) + snext(:,3)./(xnext(:,3) + 1) + snext(:,5) - snext(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - xnext(:,5))./p(12)) + 1).*(-exp((p(11) - xnext(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(p(11) + p(12) - (p(12) + xnext(:,5)).*exp((p(11) - xnext(:,5))./p(12)))./p(5))); % d eq_3 w.r.t. R
      out3(:,3,3) = s(:,3)./((x(:,3) + 1).^2.*(p(4) - s(:,1).*exp((p(11) - x(:,5))./p(12)) + s(:,3)./(x(:,3) + 1) + s(:,5) - s(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(p(11) + p(12) - (p(12) + x(:,5)).*exp((p(11) - x(:,5))./p(12)))./p(5)).^2); % d eq_3 w.r.t. PI
      out3(:,3,4) = 0; % d eq_3 w.r.t. RL
      out3(:,3,5) = (s(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(-exp((p(11) - x(:,5))./p(12)) + (p(12) + x(:,5)).*exp((p(11) - x(:,5))./p(12))./p(12))./p(5) - s(:,1).*exp((p(11) - x(:,5))./p(12))./p(12) + s(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(p(11) + p(12) - (p(12) + x(:,5)).*exp((p(11) - x(:,5))./p(12))).*exp((p(11) - x(:,5))./p(12))./(p(12).*p(5)) + s(:,1).^p(2).*(-p(2) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(p(11) + p(12) - (p(12) + x(:,5)).*exp((p(11) - x(:,5))./p(12))).*exp((p(11) - x(:,5))./p(12))./(p(12).*p(5)))./(p(4) - s(:,1).*exp((p(11) - x(:,5))./p(12)) + s(:,3)./(x(:,3) + 1) + s(:,5) - s(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(p(11) + p(12) - (p(12) + x(:,5)).*exp((p(11) - x(:,5))./p(12)))./p(5)).^2; % d eq_3 w.r.t. nu_def
      out3(:,4,1) = 0; % d eq_4 w.r.t. lamb
      out3(:,4,2) = 1; % d eq_4 w.r.t. R
      out3(:,4,3) = 0; % d eq_4 w.r.t. PI
      out3(:,4,4) = -1; % d eq_4 w.r.t. RL
      out3(:,4,5) = 0; % d eq_4 w.r.t. nu_def
      out3(:,5,1) = 0; % d eq_5 w.r.t. lamb
      out3(:,5,2) = 0; % d eq_5 w.r.t. R
      out3(:,5,3) = 0; % d eq_5 w.r.t. PI
      out3(:,5,4) = p(5).*s(:,1).*s(:,1).^(-p(2)).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(-1./(p(5) - 1))./(x(:,4).*(-p(2) + 1).*(p(5) - 1)) + p(5).*s(:,1).^(-p(2)).*(-x(:,4).*s(:,1) + s(:,1).^p(2).*(p(5)./(p(5) - 1)).^(-p(5)).*((p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1))./p(5)).^(-p(5) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(p(2) + p(5)./(p(5) - 1) - 1).*exp(s(:,4))./(p(5) - 1)).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(-1./(p(5) - 1))./(x(:,4).^2.*(-p(2) + 1).*(p(5) - 1)); % d eq_5 w.r.t. RL
      out3(:,5,5) = -p(5).*s(:,1).^(-p(2)).*(s(:,1).^p(2).*(p(5)./(p(5) - 1)).^(-p(5)).*((p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1))./p(5)).^(-p(5) + 1).*(-p(5) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(p(2) + p(5)./(p(5) - 1) - 1).*exp(s(:,4)).*exp((p(11) - x(:,5))./p(12))./(p(12).*(p(5) - 1).^2.*(-exp((p(11) - x(:,5))./p(12)) + 1)) + s(:,1).^p(2).*(p(5)./(p(5) - 1)).^(-p(5)).*((p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1))./p(5)).^(-p(5) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(p(2) + p(5)./(p(5) - 1) - 1).*(p(2) + p(5)./(p(5) - 1) - 1).*exp(s(:,4)).*exp((p(11) - x(:,5))./p(12))./(p(12).*(p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1))).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(-1./(p(5) - 1))./(x(:,4).*(-p(2) + 1).*(p(5) - 1)) + 1 + p(5).*s(:,1).^(-p(2)).*(-x(:,4).*s(:,1) + s(:,1).^p(2).*(p(5)./(p(5) - 1)).^(-p(5)).*((p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1))./p(5)).^(-p(5) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(p(2) + p(5)./(p(5) - 1) - 1).*exp(s(:,4))./(p(5) - 1)).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(-1./(p(5) - 1)).*exp((p(11) - x(:,5))./p(12))./(p(12).*x(:,4).*(-p(2) + 1).*(p(5) - 1).^2.*(-exp((p(11) - x(:,5))./p(12)) + 1)); % d eq_5 w.r.t. nu_def

    % df/dsnext
      out4 = zeros(n,5,5);
      out4(:,1,1) = -p(2).*p(1).*snext(:,1).^(p(2) - 1).*xnext(:,1).*(p(2) - 1).*(p(5) - 1).*(-exp((p(11) - xnext(:,5))./p(12)) + 1).*(-exp((p(11) - xnext(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*exp(snext(:,4))./(p(5).*snext(:,1)); % d eq_1 w.r.t. k(1)
      out4(:,1,2) = 0; % d eq_1 w.r.t. mm(1)
      out4(:,1,3) = 0; % d eq_1 w.r.t. mL(1)
      out4(:,1,4) = -p(2).*p(1).*snext(:,1).^(p(2) - 1).*xnext(:,1).*(p(5) - 1).*(-exp((p(11) - xnext(:,5))./p(12)) + 1).*(-exp((p(11) - xnext(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*exp(snext(:,4))./p(5); % d eq_1 w.r.t. z(1)
      out4(:,1,5) = 0; % d eq_1 w.r.t. u(1)
      out4(:,2,1) = 0; % d eq_2 w.r.t. k(1)
      out4(:,2,2) = 0; % d eq_2 w.r.t. mm(1)
      out4(:,2,3) = 0; % d eq_2 w.r.t. mL(1)
      out4(:,2,4) = 0; % d eq_2 w.r.t. z(1)
      out4(:,2,5) = 0; % d eq_2 w.r.t. u(1)
      out4(:,3,1) = -p(1).*x(:,2).*(p(2).*snext(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - xnext(:,5))./p(12)) + 1).*(-exp((p(11) - xnext(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(p(11) + p(12) - (p(12) + xnext(:,5)).*exp((p(11) - xnext(:,5))./p(12)))./(p(5).*snext(:,1)) + exp((p(11) - xnext(:,5))./p(12)))./((xnext(:,3) + 1).*(p(4) - snext(:,1).*exp((p(11) - xnext(:,5))./p(12)) + snext(:,3)./(xnext(:,3) + 1) + snext(:,5) - snext(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - xnext(:,5))./p(12)) + 1).*(-exp((p(11) - xnext(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(p(11) + p(12) - (p(12) + xnext(:,5)).*exp((p(11) - xnext(:,5))./p(12)))./p(5)).^2); % d eq_3 w.r.t. k(1)
      out4(:,3,2) = 0; % d eq_3 w.r.t. mm(1)
      out4(:,3,3) = p(1).*x(:,2)./((xnext(:,3) + 1).^2.*(p(4) - snext(:,1).*exp((p(11) - xnext(:,5))./p(12)) + snext(:,3)./(xnext(:,3) + 1) + snext(:,5) - snext(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - xnext(:,5))./p(12)) + 1).*(-exp((p(11) - xnext(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(p(11) + p(12) - (p(12) + xnext(:,5)).*exp((p(11) - xnext(:,5))./p(12)))./p(5)).^2); % d eq_3 w.r.t. mL(1)
      out4(:,3,4) = 0; % d eq_3 w.r.t. z(1)
      out4(:,3,5) = p(1).*x(:,2)./((xnext(:,3) + 1).*(p(4) - snext(:,1).*exp((p(11) - xnext(:,5))./p(12)) + snext(:,3)./(xnext(:,3) + 1) + snext(:,5) - snext(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - xnext(:,5))./p(12)) + 1).*(-exp((p(11) - xnext(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(p(11) + p(12) - (p(12) + xnext(:,5)).*exp((p(11) - xnext(:,5))./p(12)))./p(5)).^2); % d eq_3 w.r.t. u(1)
      out4(:,4,1) = 0; % d eq_4 w.r.t. k(1)
      out4(:,4,2) = 0; % d eq_4 w.r.t. mm(1)
      out4(:,4,3) = 0; % d eq_4 w.r.t. mL(1)
      out4(:,4,4) = 0; % d eq_4 w.r.t. z(1)
      out4(:,4,5) = 0; % d eq_4 w.r.t. u(1)
      out4(:,5,1) = 0; % d eq_5 w.r.t. k(1)
      out4(:,5,2) = 0; % d eq_5 w.r.t. mm(1)
      out4(:,5,3) = 0; % d eq_5 w.r.t. mL(1)
      out4(:,5,4) = 0; % d eq_5 w.r.t. z(1)
      out4(:,5,5) = 0; % d eq_5 w.r.t. u(1)

    % df/dxnext
      out5 = zeros(n,5,5);
      out5(:,1,1) = -p(1).*(-exp((p(11) - xnext(:,5))./p(12)) + 1).*(p(2).*snext(:,1).^(p(2) - 1).*(p(5) - 1).*(-exp((p(11) - xnext(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*exp(snext(:,4))./p(5) - p(3) + 1); % d eq_1 w.r.t. lamb(1)
      out5(:,1,2) = 0; % d eq_1 w.r.t. R(1)
      out5(:,1,3) = 0; % d eq_1 w.r.t. PI(1)
      out5(:,1,4) = 0; % d eq_1 w.r.t. RL(1)
      out5(:,1,5) = -p(2).*p(1).*snext(:,1).^(p(2) - 1).*xnext(:,1).*(-exp((p(11) - xnext(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*exp(snext(:,4)).*exp((p(11) - xnext(:,5))./p(12))./(p(12).*p(5)) - p(1).*xnext(:,1).*(p(2).*snext(:,1).^(p(2) - 1).*(p(5) - 1).*(-exp((p(11) - xnext(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*exp(snext(:,4))./p(5) - p(3) + 1).*exp((p(11) - xnext(:,5))./p(12))./p(12); % d eq_1 w.r.t. nu_def(1)
      out5(:,2,1) = -p(1).*xnext(:,2)./(xnext(:,3) + 1); % d eq_2 w.r.t. lamb(1)
      out5(:,2,2) = -p(1).*xnext(:,1)./(xnext(:,3) + 1); % d eq_2 w.r.t. R(1)
      out5(:,2,3) = p(1).*xnext(:,2).*xnext(:,1)./(xnext(:,3) + 1).^2; % d eq_2 w.r.t. PI(1)
      out5(:,2,4) = 0; % d eq_2 w.r.t. RL(1)
      out5(:,2,5) = 0; % d eq_2 w.r.t. nu_def(1)
      out5(:,3,1) = 0; % d eq_3 w.r.t. lamb(1)
      out5(:,3,2) = 0; % d eq_3 w.r.t. R(1)
      out5(:,3,3) = -p(1).*x(:,2).*snext(:,3)./((xnext(:,3) + 1).^3.*(p(4) - snext(:,1).*exp((p(11) - xnext(:,5))./p(12)) + snext(:,3)./(xnext(:,3) + 1) + snext(:,5) - snext(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - xnext(:,5))./p(12)) + 1).*(-exp((p(11) - xnext(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(p(11) + p(12) - (p(12) + xnext(:,5)).*exp((p(11) - xnext(:,5))./p(12)))./p(5)).^2) + p(1).*x(:,2)./((xnext(:,3) + 1).^2.*(p(4) - snext(:,1).*exp((p(11) - xnext(:,5))./p(12)) + snext(:,3)./(xnext(:,3) + 1) + snext(:,5) - snext(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - xnext(:,5))./p(12)) + 1).*(-exp((p(11) - xnext(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(p(11) + p(12) - (p(12) + xnext(:,5)).*exp((p(11) - xnext(:,5))./p(12)))./p(5))); % d eq_3 w.r.t. PI(1)
      out5(:,3,4) = 0; % d eq_3 w.r.t. RL(1)
      out5(:,3,5) = -p(1).*x(:,2).*(snext(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - xnext(:,5))./p(12)) + 1).*(-exp((p(11) - xnext(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(-exp((p(11) - xnext(:,5))./p(12)) + (p(12) + xnext(:,5)).*exp((p(11) - xnext(:,5))./p(12))./p(12))./p(5) - snext(:,1).*exp((p(11) - xnext(:,5))./p(12))./p(12) + snext(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - xnext(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(p(11) + p(12) - (p(12) + xnext(:,5)).*exp((p(11) - xnext(:,5))./p(12))).*exp((p(11) - xnext(:,5))./p(12))./(p(12).*p(5)) + snext(:,1).^p(2).*(-p(2) + 1).*(-exp((p(11) - xnext(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(p(11) + p(12) - (p(12) + xnext(:,5)).*exp((p(11) - xnext(:,5))./p(12))).*exp((p(11) - xnext(:,5))./p(12))./(p(12).*p(5)))./((xnext(:,3) + 1).*(p(4) - snext(:,1).*exp((p(11) - xnext(:,5))./p(12)) + snext(:,3)./(xnext(:,3) + 1) + snext(:,5) - snext(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - xnext(:,5))./p(12)) + 1).*(-exp((p(11) - xnext(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(p(11) + p(12) - (p(12) + xnext(:,5)).*exp((p(11) - xnext(:,5))./p(12)))./p(5)).^2); % d eq_3 w.r.t. nu_def(1)
      out5(:,4,1) = 0; % d eq_4 w.r.t. lamb(1)
      out5(:,4,2) = 0; % d eq_4 w.r.t. R(1)
      out5(:,4,3) = 0; % d eq_4 w.r.t. PI(1)
      out5(:,4,4) = 0; % d eq_4 w.r.t. RL(1)
      out5(:,4,5) = 0; % d eq_4 w.r.t. nu_def(1)
      out5(:,5,1) = 0; % d eq_5 w.r.t. lamb(1)
      out5(:,5,2) = 0; % d eq_5 w.r.t. R(1)
      out5(:,5,3) = 0; % d eq_5 w.r.t. PI(1)
      out5(:,5,4) = 0; % d eq_5 w.r.t. RL(1)
      out5(:,5,5) = 0; % d eq_5 w.r.t. nu_def(1)

end

        
end

function [out1,out2,out3] = g(s,x,e,p)
    n = size(s,1);

    % g

      out1 = zeros(n,5);
      out1(:,1) = -p(4) + s(:,1).*(-p(3) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1) + s(:,1).*exp((p(11) - x(:,5))./p(12)) + s(:,1).^p(2).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(p(2) + p(5)./(p(5) - 1) - 1).*exp(s(:,4)) - s(:,3)./(x(:,3) + 1) - s(:,5) + s(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(p(11) + p(12) - (p(12) + x(:,5)).*exp((p(11) - x(:,5))./p(12)))./p(5);
      out1(:,2) = s(:,2).*(p(6).*s(:,5) + p(7).*s(:,4) + p(4) + e(:,2) + 1)./(x(:,3) + 1);
      out1(:,3) = s(:,2)./(x(:,3) + 1);
      out1(:,4) = p(8).*s(:,4) + e(:,1);
      out1(:,5) = p(6).*s(:,5) + p(7).*s(:,4) + e(:,2);

if nargout >=2
    % dg/ds
          out2 = zeros(n,5,5);
      out2(:,1,1) = p(2).*s(:,1).^p(2).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(p(2) + p(5)./(p(5) - 1) - 1).*exp(s(:,4))./s(:,1) + p(2).*s(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(p(11) + p(12) - (p(12) + x(:,5)).*exp((p(11) - x(:,5))./p(12)))./(p(5).*s(:,1)) + (-p(3) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1) + exp((p(11) - x(:,5))./p(12)); % d eq_1 w.r.t. k
      out2(:,1,2) = 0; % d eq_1 w.r.t. mm
      out2(:,1,3) = -1./(x(:,3) + 1); % d eq_1 w.r.t. mL
      out2(:,1,4) = s(:,1).^p(2).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(p(2) + p(5)./(p(5) - 1) - 1).*exp(s(:,4)); % d eq_1 w.r.t. z
      out2(:,1,5) = -1; % d eq_1 w.r.t. u
      out2(:,2,1) = 0; % d eq_2 w.r.t. k
      out2(:,2,2) = (p(6).*s(:,5) + p(7).*s(:,4) + p(4) + e(:,2) + 1)./(x(:,3) + 1); % d eq_2 w.r.t. mm
      out2(:,2,3) = 0; % d eq_2 w.r.t. mL
      out2(:,2,4) = p(7).*s(:,2)./(x(:,3) + 1); % d eq_2 w.r.t. z
      out2(:,2,5) = p(6).*s(:,2)./(x(:,3) + 1); % d eq_2 w.r.t. u
      out2(:,3,1) = 0; % d eq_3 w.r.t. k
      out2(:,3,2) = 1./(x(:,3) + 1); % d eq_3 w.r.t. mm
      out2(:,3,3) = 0; % d eq_3 w.r.t. mL
      out2(:,3,4) = 0; % d eq_3 w.r.t. z
      out2(:,3,5) = 0; % d eq_3 w.r.t. u
      out2(:,4,1) = 0; % d eq_4 w.r.t. k
      out2(:,4,2) = 0; % d eq_4 w.r.t. mm
      out2(:,4,3) = 0; % d eq_4 w.r.t. mL
      out2(:,4,4) = p(8); % d eq_4 w.r.t. z
      out2(:,4,5) = 0; % d eq_4 w.r.t. u
      out2(:,5,1) = 0; % d eq_5 w.r.t. k
      out2(:,5,2) = 0; % d eq_5 w.r.t. mm
      out2(:,5,3) = 0; % d eq_5 w.r.t. mL
      out2(:,5,4) = p(7); % d eq_5 w.r.t. z
      out2(:,5,5) = p(6); % d eq_5 w.r.t. u
    % dg/dx
          out3 = zeros(n,5,5);
      out3(:,1,1) = 0; % d eq_1 w.r.t. lamb
      out3(:,1,2) = 0; % d eq_1 w.r.t. R
      out3(:,1,3) = s(:,3)./(x(:,3) + 1).^2; % d eq_1 w.r.t. PI
      out3(:,1,4) = 0; % d eq_1 w.r.t. RL
      out3(:,1,5) = s(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(-exp((p(11) - x(:,5))./p(12)) + (p(12) + x(:,5)).*exp((p(11) - x(:,5))./p(12))./p(12))./p(5) + s(:,1).*(-p(3) + 1).*exp((p(11) - x(:,5))./p(12))./p(12) - s(:,1).*exp((p(11) - x(:,5))./p(12))./p(12) + s(:,1).^p(2).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(p(2) + p(5)./(p(5) - 1) - 1).*(p(2) + p(5)./(p(5) - 1) - 1).*exp(s(:,4)).*exp((p(11) - x(:,5))./p(12))./(p(12).*(-exp((p(11) - x(:,5))./p(12)) + 1)) + s(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(p(11) + p(12) - (p(12) + x(:,5)).*exp((p(11) - x(:,5))./p(12))).*exp((p(11) - x(:,5))./p(12))./(p(12).*p(5)) + s(:,1).^p(2).*(-p(2) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(p(11) + p(12) - (p(12) + x(:,5)).*exp((p(11) - x(:,5))./p(12))).*exp((p(11) - x(:,5))./p(12))./(p(12).*p(5)); % d eq_1 w.r.t. nu_def
      out3(:,2,1) = 0; % d eq_2 w.r.t. lamb
      out3(:,2,2) = 0; % d eq_2 w.r.t. R
      out3(:,2,3) = -s(:,2).*(p(6).*s(:,5) + p(7).*s(:,4) + p(4) + e(:,2) + 1)./(x(:,3) + 1).^2; % d eq_2 w.r.t. PI
      out3(:,2,4) = 0; % d eq_2 w.r.t. RL
      out3(:,2,5) = 0; % d eq_2 w.r.t. nu_def
      out3(:,3,1) = 0; % d eq_3 w.r.t. lamb
      out3(:,3,2) = 0; % d eq_3 w.r.t. R
      out3(:,3,3) = -s(:,2)./(x(:,3) + 1).^2; % d eq_3 w.r.t. PI
      out3(:,3,4) = 0; % d eq_3 w.r.t. RL
      out3(:,3,5) = 0; % d eq_3 w.r.t. nu_def
      out3(:,4,1) = 0; % d eq_4 w.r.t. lamb
      out3(:,4,2) = 0; % d eq_4 w.r.t. R
      out3(:,4,3) = 0; % d eq_4 w.r.t. PI
      out3(:,4,4) = 0; % d eq_4 w.r.t. RL
      out3(:,4,5) = 0; % d eq_4 w.r.t. nu_def
      out3(:,5,1) = 0; % d eq_5 w.r.t. lamb
      out3(:,5,2) = 0; % d eq_5 w.r.t. R
      out3(:,5,3) = 0; % d eq_5 w.r.t. PI
      out3(:,5,4) = 0; % d eq_5 w.r.t. RL
      out3(:,5,5) = 0; % d eq_5 w.r.t. nu_def
end
        
end

function [out1,out2,out3] = a(s,x,p)
    n = size(s,1);

    % a

      out1 = zeros(n,13);
      out1(:,1) = -exp((p(11) - x(:,5))./p(12)) + 1;
      out1(:,2) = (p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1))./p(5);
      out1(:,3) = s(:,1).^p(2).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(p(2) + p(5)./(p(5) - 1) - 1).*exp(s(:,4));
      out1(:,4) = s(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*exp(s(:,4))./p(5);
      out1(:,5) = s(:,1).^p(2).*(p(5)./(p(5) - 1)).^(-p(5)).*((p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1))./p(5)).^(-p(5) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(p(2) + p(5)./(p(5) - 1) - 1).*exp(s(:,4))./(p(5) - 1);
      out1(:,6) = p(2).*s(:,1).^(p(2) - 1).*(p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*exp(s(:,4))./p(5);
      out1(:,7) = p(4) + s(:,5);
      out1(:,8) = p(11) + p(12) - (p(12) + x(:,5)).*exp((p(11) - x(:,5))./p(12));
      out1(:,9) = -p(4) + s(:,1).*exp((p(11) - x(:,5))./p(12)) - s(:,5) + s(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(p(11) + p(12) - (p(12) + x(:,5)).*exp((p(11) - x(:,5))./p(12)))./p(5);
      out1(:,10) = s(:,2)./(x(:,3) + 1);
      out1(:,11) = p(4) - s(:,1).*exp((p(11) - x(:,5))./p(12)) + s(:,3)./(x(:,3) + 1) + s(:,5) - s(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(p(11) + p(12) - (p(12) + x(:,5)).*exp((p(11) - x(:,5))./p(12)))./p(5);
      out1(:,12) = 1./(p(4) - s(:,1).*exp((p(11) - x(:,5))./p(12)) + s(:,3)./(x(:,3) + 1) + s(:,5) - s(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(p(11) + p(12) - (p(12) + x(:,5)).*exp((p(11) - x(:,5))./p(12)))./p(5));
      out1(:,13) = -p(4) + s(:,1).*exp((p(11) - x(:,5))./p(12)) + s(:,1).^p(2).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(p(2) + p(5)./(p(5) - 1) - 1).*exp(s(:,4)) - s(:,3)./(x(:,3) + 1) - s(:,5) + s(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(p(11) + p(12) - (p(12) + x(:,5)).*exp((p(11) - x(:,5))./p(12)))./p(5);

if nargout >=2
    % da/ds
          out2 = zeros(n,13,5);
      out2(:,1,1) = 0; % d eq_1 w.r.t. k
      out2(:,1,2) = 0; % d eq_1 w.r.t. mm
      out2(:,1,3) = 0; % d eq_1 w.r.t. mL
      out2(:,1,4) = 0; % d eq_1 w.r.t. z
      out2(:,1,5) = 0; % d eq_1 w.r.t. u
      out2(:,2,1) = 0; % d eq_2 w.r.t. k
      out2(:,2,2) = 0; % d eq_2 w.r.t. mm
      out2(:,2,3) = 0; % d eq_2 w.r.t. mL
      out2(:,2,4) = 0; % d eq_2 w.r.t. z
      out2(:,2,5) = 0; % d eq_2 w.r.t. u
      out2(:,3,1) = p(2).*s(:,1).^p(2).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(p(2) + p(5)./(p(5) - 1) - 1).*exp(s(:,4))./s(:,1); % d eq_3 w.r.t. k
      out2(:,3,2) = 0; % d eq_3 w.r.t. mm
      out2(:,3,3) = 0; % d eq_3 w.r.t. mL
      out2(:,3,4) = s(:,1).^p(2).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(p(2) + p(5)./(p(5) - 1) - 1).*exp(s(:,4)); % d eq_3 w.r.t. z
      out2(:,3,5) = 0; % d eq_3 w.r.t. u
      out2(:,4,1) = p(2).*s(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*exp(s(:,4))./(p(5).*s(:,1)); % d eq_4 w.r.t. k
      out2(:,4,2) = 0; % d eq_4 w.r.t. mm
      out2(:,4,3) = 0; % d eq_4 w.r.t. mL
      out2(:,4,4) = s(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*exp(s(:,4))./p(5); % d eq_4 w.r.t. z
      out2(:,4,5) = 0; % d eq_4 w.r.t. u
      out2(:,5,1) = p(2).*s(:,1).^p(2).*(p(5)./(p(5) - 1)).^(-p(5)).*((p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1))./p(5)).^(-p(5) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(p(2) + p(5)./(p(5) - 1) - 1).*exp(s(:,4))./(s(:,1).*(p(5) - 1)); % d eq_5 w.r.t. k
      out2(:,5,2) = 0; % d eq_5 w.r.t. mm
      out2(:,5,3) = 0; % d eq_5 w.r.t. mL
      out2(:,5,4) = s(:,1).^p(2).*(p(5)./(p(5) - 1)).^(-p(5)).*((p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1))./p(5)).^(-p(5) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(p(2) + p(5)./(p(5) - 1) - 1).*exp(s(:,4))./(p(5) - 1); % d eq_5 w.r.t. z
      out2(:,5,5) = 0; % d eq_5 w.r.t. u
      out2(:,6,1) = p(2).*s(:,1).^(p(2) - 1).*(p(2) - 1).*(p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*exp(s(:,4))./(p(5).*s(:,1)); % d eq_6 w.r.t. k
      out2(:,6,2) = 0; % d eq_6 w.r.t. mm
      out2(:,6,3) = 0; % d eq_6 w.r.t. mL
      out2(:,6,4) = p(2).*s(:,1).^(p(2) - 1).*(p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*exp(s(:,4))./p(5); % d eq_6 w.r.t. z
      out2(:,6,5) = 0; % d eq_6 w.r.t. u
      out2(:,7,1) = 0; % d eq_7 w.r.t. k
      out2(:,7,2) = 0; % d eq_7 w.r.t. mm
      out2(:,7,3) = 0; % d eq_7 w.r.t. mL
      out2(:,7,4) = 0; % d eq_7 w.r.t. z
      out2(:,7,5) = 1; % d eq_7 w.r.t. u
      out2(:,8,1) = 0; % d eq_8 w.r.t. k
      out2(:,8,2) = 0; % d eq_8 w.r.t. mm
      out2(:,8,3) = 0; % d eq_8 w.r.t. mL
      out2(:,8,4) = 0; % d eq_8 w.r.t. z
      out2(:,8,5) = 0; % d eq_8 w.r.t. u
      out2(:,9,1) = p(2).*s(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(p(11) + p(12) - (p(12) + x(:,5)).*exp((p(11) - x(:,5))./p(12)))./(p(5).*s(:,1)) + exp((p(11) - x(:,5))./p(12)); % d eq_9 w.r.t. k
      out2(:,9,2) = 0; % d eq_9 w.r.t. mm
      out2(:,9,3) = 0; % d eq_9 w.r.t. mL
      out2(:,9,4) = 0; % d eq_9 w.r.t. z
      out2(:,9,5) = -1; % d eq_9 w.r.t. u
      out2(:,10,1) = 0; % d eq_10 w.r.t. k
      out2(:,10,2) = 1./(x(:,3) + 1); % d eq_10 w.r.t. mm
      out2(:,10,3) = 0; % d eq_10 w.r.t. mL
      out2(:,10,4) = 0; % d eq_10 w.r.t. z
      out2(:,10,5) = 0; % d eq_10 w.r.t. u
      out2(:,11,1) = -p(2).*s(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(p(11) + p(12) - (p(12) + x(:,5)).*exp((p(11) - x(:,5))./p(12)))./(p(5).*s(:,1)) - exp((p(11) - x(:,5))./p(12)); % d eq_11 w.r.t. k
      out2(:,11,2) = 0; % d eq_11 w.r.t. mm
      out2(:,11,3) = 1./(x(:,3) + 1); % d eq_11 w.r.t. mL
      out2(:,11,4) = 0; % d eq_11 w.r.t. z
      out2(:,11,5) = 1; % d eq_11 w.r.t. u
      out2(:,12,1) = (p(2).*s(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(p(11) + p(12) - (p(12) + x(:,5)).*exp((p(11) - x(:,5))./p(12)))./(p(5).*s(:,1)) + exp((p(11) - x(:,5))./p(12)))./(p(4) - s(:,1).*exp((p(11) - x(:,5))./p(12)) + s(:,3)./(x(:,3) + 1) + s(:,5) - s(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(p(11) + p(12) - (p(12) + x(:,5)).*exp((p(11) - x(:,5))./p(12)))./p(5)).^2; % d eq_12 w.r.t. k
      out2(:,12,2) = 0; % d eq_12 w.r.t. mm
      out2(:,12,3) = -1./((x(:,3) + 1).*(p(4) - s(:,1).*exp((p(11) - x(:,5))./p(12)) + s(:,3)./(x(:,3) + 1) + s(:,5) - s(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(p(11) + p(12) - (p(12) + x(:,5)).*exp((p(11) - x(:,5))./p(12)))./p(5)).^2); % d eq_12 w.r.t. mL
      out2(:,12,4) = 0; % d eq_12 w.r.t. z
      out2(:,12,5) = -1./(p(4) - s(:,1).*exp((p(11) - x(:,5))./p(12)) + s(:,3)./(x(:,3) + 1) + s(:,5) - s(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(p(11) + p(12) - (p(12) + x(:,5)).*exp((p(11) - x(:,5))./p(12)))./p(5)).^2; % d eq_12 w.r.t. u
      out2(:,13,1) = p(2).*s(:,1).^p(2).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(p(2) + p(5)./(p(5) - 1) - 1).*exp(s(:,4))./s(:,1) + p(2).*s(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(p(11) + p(12) - (p(12) + x(:,5)).*exp((p(11) - x(:,5))./p(12)))./(p(5).*s(:,1)) + exp((p(11) - x(:,5))./p(12)); % d eq_13 w.r.t. k
      out2(:,13,2) = 0; % d eq_13 w.r.t. mm
      out2(:,13,3) = -1./(x(:,3) + 1); % d eq_13 w.r.t. mL
      out2(:,13,4) = s(:,1).^p(2).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(p(2) + p(5)./(p(5) - 1) - 1).*exp(s(:,4)); % d eq_13 w.r.t. z
      out2(:,13,5) = -1; % d eq_13 w.r.t. u
    % da/dx
          out3 = zeros(n,13,5);
      out3(:,1,1) = 0; % d eq_1 w.r.t. lamb
      out3(:,1,2) = 0; % d eq_1 w.r.t. R
      out3(:,1,3) = 0; % d eq_1 w.r.t. PI
      out3(:,1,4) = 0; % d eq_1 w.r.t. RL
      out3(:,1,5) = exp((p(11) - x(:,5))./p(12))./p(12); % d eq_1 w.r.t. nu_def
      out3(:,2,1) = 0; % d eq_2 w.r.t. lamb
      out3(:,2,2) = 0; % d eq_2 w.r.t. R
      out3(:,2,3) = 0; % d eq_2 w.r.t. PI
      out3(:,2,4) = 0; % d eq_2 w.r.t. RL
      out3(:,2,5) = (-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*exp((p(11) - x(:,5))./p(12))./(p(12).*p(5).*(-exp((p(11) - x(:,5))./p(12)) + 1)); % d eq_2 w.r.t. nu_def
      out3(:,3,1) = 0; % d eq_3 w.r.t. lamb
      out3(:,3,2) = 0; % d eq_3 w.r.t. R
      out3(:,3,3) = 0; % d eq_3 w.r.t. PI
      out3(:,3,4) = 0; % d eq_3 w.r.t. RL
      out3(:,3,5) = s(:,1).^p(2).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(p(2) + p(5)./(p(5) - 1) - 1).*(p(2) + p(5)./(p(5) - 1) - 1).*exp(s(:,4)).*exp((p(11) - x(:,5))./p(12))./(p(12).*(-exp((p(11) - x(:,5))./p(12)) + 1)); % d eq_3 w.r.t. nu_def
      out3(:,4,1) = 0; % d eq_4 w.r.t. lamb
      out3(:,4,2) = 0; % d eq_4 w.r.t. R
      out3(:,4,3) = 0; % d eq_4 w.r.t. PI
      out3(:,4,4) = 0; % d eq_4 w.r.t. RL
      out3(:,4,5) = s(:,1).^p(2).*(-p(2) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*exp(s(:,4)).*exp((p(11) - x(:,5))./p(12))./(p(12).*p(5).*(-exp((p(11) - x(:,5))./p(12)) + 1)); % d eq_4 w.r.t. nu_def
      out3(:,5,1) = 0; % d eq_5 w.r.t. lamb
      out3(:,5,2) = 0; % d eq_5 w.r.t. R
      out3(:,5,3) = 0; % d eq_5 w.r.t. PI
      out3(:,5,4) = 0; % d eq_5 w.r.t. RL
      out3(:,5,5) = s(:,1).^p(2).*(p(5)./(p(5) - 1)).^(-p(5)).*((p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1))./p(5)).^(-p(5) + 1).*(-p(5) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(p(2) + p(5)./(p(5) - 1) - 1).*exp(s(:,4)).*exp((p(11) - x(:,5))./p(12))./(p(12).*(p(5) - 1).^2.*(-exp((p(11) - x(:,5))./p(12)) + 1)) + s(:,1).^p(2).*(p(5)./(p(5) - 1)).^(-p(5)).*((p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1))./p(5)).^(-p(5) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(p(2) + p(5)./(p(5) - 1) - 1).*(p(2) + p(5)./(p(5) - 1) - 1).*exp(s(:,4)).*exp((p(11) - x(:,5))./p(12))./(p(12).*(p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1)); % d eq_5 w.r.t. nu_def
      out3(:,6,1) = 0; % d eq_6 w.r.t. lamb
      out3(:,6,2) = 0; % d eq_6 w.r.t. R
      out3(:,6,3) = 0; % d eq_6 w.r.t. PI
      out3(:,6,4) = 0; % d eq_6 w.r.t. RL
      out3(:,6,5) = p(2).*s(:,1).^(p(2) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*exp(s(:,4)).*exp((p(11) - x(:,5))./p(12))./(p(12).*p(5).*(-exp((p(11) - x(:,5))./p(12)) + 1)); % d eq_6 w.r.t. nu_def
      out3(:,7,1) = 0; % d eq_7 w.r.t. lamb
      out3(:,7,2) = 0; % d eq_7 w.r.t. R
      out3(:,7,3) = 0; % d eq_7 w.r.t. PI
      out3(:,7,4) = 0; % d eq_7 w.r.t. RL
      out3(:,7,5) = 0; % d eq_7 w.r.t. nu_def
      out3(:,8,1) = 0; % d eq_8 w.r.t. lamb
      out3(:,8,2) = 0; % d eq_8 w.r.t. R
      out3(:,8,3) = 0; % d eq_8 w.r.t. PI
      out3(:,8,4) = 0; % d eq_8 w.r.t. RL
      out3(:,8,5) = -exp((p(11) - x(:,5))./p(12)) + (p(12) + x(:,5)).*exp((p(11) - x(:,5))./p(12))./p(12); % d eq_8 w.r.t. nu_def
      out3(:,9,1) = 0; % d eq_9 w.r.t. lamb
      out3(:,9,2) = 0; % d eq_9 w.r.t. R
      out3(:,9,3) = 0; % d eq_9 w.r.t. PI
      out3(:,9,4) = 0; % d eq_9 w.r.t. RL
      out3(:,9,5) = s(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(-exp((p(11) - x(:,5))./p(12)) + (p(12) + x(:,5)).*exp((p(11) - x(:,5))./p(12))./p(12))./p(5) - s(:,1).*exp((p(11) - x(:,5))./p(12))./p(12) + s(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(p(11) + p(12) - (p(12) + x(:,5)).*exp((p(11) - x(:,5))./p(12))).*exp((p(11) - x(:,5))./p(12))./(p(12).*p(5)) + s(:,1).^p(2).*(-p(2) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(p(11) + p(12) - (p(12) + x(:,5)).*exp((p(11) - x(:,5))./p(12))).*exp((p(11) - x(:,5))./p(12))./(p(12).*p(5)); % d eq_9 w.r.t. nu_def
      out3(:,10,1) = 0; % d eq_10 w.r.t. lamb
      out3(:,10,2) = 0; % d eq_10 w.r.t. R
      out3(:,10,3) = -s(:,2)./(x(:,3) + 1).^2; % d eq_10 w.r.t. PI
      out3(:,10,4) = 0; % d eq_10 w.r.t. RL
      out3(:,10,5) = 0; % d eq_10 w.r.t. nu_def
      out3(:,11,1) = 0; % d eq_11 w.r.t. lamb
      out3(:,11,2) = 0; % d eq_11 w.r.t. R
      out3(:,11,3) = -s(:,3)./(x(:,3) + 1).^2; % d eq_11 w.r.t. PI
      out3(:,11,4) = 0; % d eq_11 w.r.t. RL
      out3(:,11,5) = -s(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(-exp((p(11) - x(:,5))./p(12)) + (p(12) + x(:,5)).*exp((p(11) - x(:,5))./p(12))./p(12))./p(5) + s(:,1).*exp((p(11) - x(:,5))./p(12))./p(12) - s(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(p(11) + p(12) - (p(12) + x(:,5)).*exp((p(11) - x(:,5))./p(12))).*exp((p(11) - x(:,5))./p(12))./(p(12).*p(5)) - s(:,1).^p(2).*(-p(2) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(p(11) + p(12) - (p(12) + x(:,5)).*exp((p(11) - x(:,5))./p(12))).*exp((p(11) - x(:,5))./p(12))./(p(12).*p(5)); % d eq_11 w.r.t. nu_def
      out3(:,12,1) = 0; % d eq_12 w.r.t. lamb
      out3(:,12,2) = 0; % d eq_12 w.r.t. R
      out3(:,12,3) = s(:,3)./((x(:,3) + 1).^2.*(p(4) - s(:,1).*exp((p(11) - x(:,5))./p(12)) + s(:,3)./(x(:,3) + 1) + s(:,5) - s(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(p(11) + p(12) - (p(12) + x(:,5)).*exp((p(11) - x(:,5))./p(12)))./p(5)).^2); % d eq_12 w.r.t. PI
      out3(:,12,4) = 0; % d eq_12 w.r.t. RL
      out3(:,12,5) = (s(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(-exp((p(11) - x(:,5))./p(12)) + (p(12) + x(:,5)).*exp((p(11) - x(:,5))./p(12))./p(12))./p(5) - s(:,1).*exp((p(11) - x(:,5))./p(12))./p(12) + s(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(p(11) + p(12) - (p(12) + x(:,5)).*exp((p(11) - x(:,5))./p(12))).*exp((p(11) - x(:,5))./p(12))./(p(12).*p(5)) + s(:,1).^p(2).*(-p(2) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(p(11) + p(12) - (p(12) + x(:,5)).*exp((p(11) - x(:,5))./p(12))).*exp((p(11) - x(:,5))./p(12))./(p(12).*p(5)))./(p(4) - s(:,1).*exp((p(11) - x(:,5))./p(12)) + s(:,3)./(x(:,3) + 1) + s(:,5) - s(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(p(11) + p(12) - (p(12) + x(:,5)).*exp((p(11) - x(:,5))./p(12)))./p(5)).^2; % d eq_12 w.r.t. nu_def
      out3(:,13,1) = 0; % d eq_13 w.r.t. lamb
      out3(:,13,2) = 0; % d eq_13 w.r.t. R
      out3(:,13,3) = s(:,3)./(x(:,3) + 1).^2; % d eq_13 w.r.t. PI
      out3(:,13,4) = 0; % d eq_13 w.r.t. RL
      out3(:,13,5) = s(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(-exp((p(11) - x(:,5))./p(12)) + (p(12) + x(:,5)).*exp((p(11) - x(:,5))./p(12))./p(12))./p(5) - s(:,1).*exp((p(11) - x(:,5))./p(12))./p(12) + s(:,1).^p(2).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(p(2) + p(5)./(p(5) - 1) - 1).*(p(2) + p(5)./(p(5) - 1) - 1).*exp(s(:,4)).*exp((p(11) - x(:,5))./p(12))./(p(12).*(-exp((p(11) - x(:,5))./p(12)) + 1)) + s(:,1).^p(2).*(-p(2) + 1).*(p(5) - 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(p(11) + p(12) - (p(12) + x(:,5)).*exp((p(11) - x(:,5))./p(12))).*exp((p(11) - x(:,5))./p(12))./(p(12).*p(5)) + s(:,1).^p(2).*(-p(2) + 1).*(-exp((p(11) - x(:,5))./p(12)) + 1).^(1./(p(5) - 1)).*(p(11) + p(12) - (p(12) + x(:,5)).*exp((p(11) - x(:,5))./p(12))).*exp((p(11) - x(:,5))./p(12))./(p(12).*p(5)); % d eq_13 w.r.t. nu_def
end
                    
end

function [out1] = model_info() % informations about the model

    mod = struct;
    mod.states = { 'k','mm','mL','z','u' };
    mod.controls = { 'lamb','R','PI','RL','nu_def' };
    mod.auxiliaries = { 'Phi','mu','y','w','pro','rk','x','Enu_def','d','m','c','uc','I' };
    mod.parameters = { 'beta','alpha','delta','x_ss','theta','gamma','varphi','rho','sigma_z','sigma_u','me','sigma' };
    mod.s_ss = [12.7096 ; -6.19297731685 ; -6.11652080677 ; 0.0 ; 0.0];
    mod.x_ss = [0.520805157585 ; 1.02376137513 ; 0.0125 ; 1.02376137513 ; -9.2846];
    mod.params = [ 0.989   0.36    0.019   0.0125  6.      0.5     0.      0.95    0.007  0.0089 -5.6879 -1.    ];
    mod.X = cell(2,1);
    mod.X{1} = [ 0.52080516  1.02376138  0.0125      1.02376138 -9.2846    ];
    mod.X{2} = [[  4.67104532e-04   6.95369711e-04  -7.04061832e-04  -1.74606907e-01   -1.62215975e-02 ;  -5.48987250e-01   1.01880599e-01  -1.03154107e-01  -3.54897265e+00   -4.99786986e-01 ;   8.53550176e-02  -3.64252315e-02  -1.28654736e-01   1.40708623e+00    1.88158012e-02 ;  -5.48987250e-01   1.01880599e-01  -1.03154107e-01  -3.54897265e+00   -4.99786986e-01 ;  -3.01914933e-01  -2.94921953e-02   2.98608477e-02   1.32370604e+00    1.44677352e-01]];
    out1 = mod;

end