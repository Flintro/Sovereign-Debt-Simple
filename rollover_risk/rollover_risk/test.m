% [X,Y]  = meshgrid(-3:0.25:3);
% x_grid = -1:0.1:1;
% y_grid = -1:0.1:1;
% vals   = [0.5*x_grid ; 0.6*y_grid];
% VV     = interp2(x_grid,y_grid,vals,0.5, 0.5, 'linear')


y_low    = 0.9;
y_high   = 1.5;
dist_y   = makedist('Uniform','Lower',y_low,'Upper',y_high);
y_grid   = y_low:0.02:y_high;
y_1      = dist_y.mean;
penalty  = 0.05;
beta     = 0.93;
R_inv    = 1;
gam      = 0.8;
b_min    = -1;
b_max    = 0.95;

b_range     = b_min:0.02:b_max;

[X,Y] = meshgrid(y_grid,b_range);
V = X.^2 + Y.^2;

[Xq,Yq] = meshgrid(y_grid,b_range);

Vq = interp2(X,Y,V,Xq,Yq,'linear');

figure
surf(Xq,Yq,Vq);
title('Linear Interpolation Over Finer Grid');