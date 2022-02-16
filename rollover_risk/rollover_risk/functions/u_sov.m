function output = u_sov(c,gam)

if c>0.01
% output = (1-exp(-gam.*c))./(1-gam);
    output = c.^(1-gam)./(1-gam);
else
    output = -8888888888888-800*abs(c);

end