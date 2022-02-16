function val = fn_valfun_R(b_2, b_1, y, V_R_grid, beta, q, E_u_sum, dist_y, Bb, Yy, y_grid, gam)

V = interp2(Yy,Bb,V_R_grid,y_grid,b_2,'linear'); %(Y,B) = interp vals
EV= mean(V);
c = y - b_1 + q*b_2;

% if c<= 0.01 
%     val =  -8888888888888-800*abs(c); % Stops negatives and complex numbers
% else
    val = u_sov(c,gam) + beta*max(EV,E_u_sum);
    
% end 
val = -val;
