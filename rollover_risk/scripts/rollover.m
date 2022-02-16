%% Aguiar and Amador 2-Period Rollover Crisis Model

%% Setup
V_low = 4.2;
V_high = 4.9;
y_1 = 1;
y_2 = 1; %% b_2 is bounded by y_2
% y_low  = 0.8;
% y_high = 1.2;
% y_1 = unifrnd(y_low, y_high);
% y_2 = unifrnd(y_low, y_high);
beta  = 0.93;
R_inv = 1;
gam = 0.8;
% y_range = 0:0.02:1.5;
b_range         = -1:0.02:0.95;
% b2_range        = -1:0.02:1.95;
pol_grid        = zeros(1,length(b_range));
V_R_max_grid    = zeros(1,length(b_range));
q_EG_grid       = zeros(1,length(b_range));
q_crisis_grid   = zeros(1,length(b_range));

%% Functions
% options = optimoptions('Display', 'off');
F_2 = @(x) unifcdf(x,V_low,V_high);
dist_v_D = makedist('Uniform','Lower',V_low,'Upper',V_high);
v_D = dist_v_D.random;

q_EG_guess    = ones(1,length(b_range));
V_2           = @(b_2) F_2(u_sov(y_2 - b_2, gam))*u_sov(y_2 - b_2, gam) ...
                       + integral(@(x) x.*dist_v_D.pdf(x),u_sov(y_2 - b_2,gam),V_high);
q_EG_func     = @(b_2) R_inv.*F_2(u_sov(y_2 - b_2, gam));
q_crisis_func = @(b_2) R_inv.*(1).*((b_2 < 0)) + 0.*((b_2>=0)); % piecewise(b_2 < 0,1,b_2 > 0,0);
V_R           = @(b_1,b_2) u_sov(y_1 - b_1 + q_EG_func(b_2)*b_2,gam) + beta*V_2(b_2);


for i = 1:length(b_range)
    V_R_temp = @(b_2) V_R(b_range(i),b_2);
    [pol,V_1_pre] = fminunc(@(b_2) - V_R_temp(b_2),0);
    pol_grid(i) = pol;
    V_R_max_grid(i) = -V_1_pre;
    q_EG_grid(i) = q_EG_func(pol);
    q_crisis_grid(i) = q_crisis_func(pol);
end

fig_rollover_value(b_range,V_R_max_grid,pol_grid,q_EG_grid,q_crisis_grid,optfig)
% figure
% plot(b_range,F_2(u_sov(y_2 - b_range, gam)))
% 
% figure
% plot(b_range,pol_grid)

% %% Convergence parameters
% tol = 1e-04;
% maxits = 100;
% diff = 10;
% 
% %% Compute Repayment value under EG timing
% 
% while diff > tol && its < maxits
%     
%     func_V_R = @(b_1,b_2) u_sov(y_1 - b_1 + q_EG 
%     for i = 1:length(b_range)
%         V
%         
%     end
%     
% end

