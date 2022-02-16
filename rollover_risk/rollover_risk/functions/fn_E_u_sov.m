function output = fn_E_u_sov(gam,y_low,y_high,dist_y)

% integrand      = @(y) ((1-exp(-gam.*y))./(1-gam)).*dist_y.pdf(y);
integrand    = @(y) (y.^(1-gam)./(1-gam)).*dist_y.pdf(y);

output = integral(integrand,y_low,y_high);


end