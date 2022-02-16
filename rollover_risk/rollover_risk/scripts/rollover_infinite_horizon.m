%% Setup
y_low    = 0.7;
y_high   = 1.5;
dist_y   = makedist('Uniform','Lower',y_low,'Upper',y_high);
y_grid   = y_low:0.02:y_high;
y_1      = dist_y.mean + 0.1;
penalty  = 0.1;
beta     = 0.8;
R_inv    = 1;
gam      = 0.8;
b_min    = -0.5;
b_max    = 1.25;
b_spc    = 0.05;

b_range         = b_min:b_spc:b_max;
pol_grid        = zeros(length(b_range),length(y_grid));
V_R_grid        = zeros(length(b_range),length(y_grid));
V_grid          = zeros(length(b_range),length(y_grid));
% V_R_max_grid    = zeros(1,length(b_range));
q_EG_grid       = 0.5*ones(length(b_range),length(y_grid));
q_crisis_grid   = zeros(length(b_range),length(y_grid));

%% Aux Functions
% options = optimoptions('Display', 'off');
E_u_sum           = fn_E_u_sov(gam,y_low,y_high,dist_y)/(1-beta);

%% Convergence parameters and objects
tol = 1e-04;
maxits = 100;
diff = 10;
its  = 0;
V_R_grid_old    = zeros(length(b_range),length(y_grid));
q_EG_grid_old   = ones(length(b_range),length(y_grid));
% V_grid_old    = zeros(length(b_range),length(b_range));

%% Compute Repayment value under EG timing

[Yy,Bb] = meshgrid(y_grid, b_range);
default_state_grid = zeros(length(b_range),length(y_grid)); % 0 = default, 1 = repay

while diff > tol && its < maxits
    
    for i = 1:length(y_grid)
        for j = 1:length(b_range)
            [pol_grid(j,i),V_R_grid(j,i)] = fminbnd(@(b_2)fn_valfun_R...
                (b_2,b_range(j),y_grid(i),V_R_grid,beta,q_EG_grid(j,i),E_u_sum,dist_y,Bb,Yy,y_grid,gam), b_min, b_max);
%             V_grid(j,i)     = fn_valfun_R(pol_grid(j,i),b_range(j),y_grid(i),V_R_grid,beta,q,E_u_sum,dist_y,Bb,Yy,y_grid,gam);
        end
    end
    V_R_grid = -V_R_grid;
    for j = 1:length(b_range)
        for i = 1:length(y_grid)
            if -fn_valfun_R(pol_grid(j,i),b_range(j),y_grid(i),V_R_grid,beta,q_EG_grid(j,i),E_u_sum,dist_y,Bb,Yy,y_grid,gam)...
                    >= u_sov(y_low,gam) + beta*E_u_sum
               default_state_grid(j,i) = 1; % 0 = default, 1 = repay
            end
        end
    end

    for j = 1:length(b_range)
        for i = 1:length(y_grid)
            q_EG_grid(j,i) = mean(default_state_grid(j,:));
        end
    end
%     
    diff  = norm(V_R_grid_old - V_R_grid);
    diffq = norm(q_EG_grid_old - q_EG_grid);
    V_R_grid_old = V_R_grid;
    q_EG_grid_old = q_EG_grid;
    its = its+1;
    fprintf('Iteration %d \n', its)
    fprintf('DIFF %d \n', diff)
    fprintf('DIFF Q %d \n', diffq)
end

% fig_rollover_value(b_range,V_R_grid,pol_grid,q_EG_grid(:,floor(length(y_grid)/2)),zeros(1,length(q_EG_grid)),optfig)

figure
plot(b_range, V_R_grid(:,floor(length(y_grid)/2)) );
figure
plot(b_range, pol_grid(:,floor(length(y_grid)/2)) );
figure
plot(y_grid, pol_grid(floor(length(b_range)/2),:) );
figure
plot(y_grid, V_R_grid(floor(length(b_range)/2),:) );
figure
plot(b_range,q_EG_grid(:,floor(length(y_grid)/2)) )
% 
% fig_rollover_value(b_range,V_R_max_grid,pol_grid,q_EG_grid,q_crisis_grid,optfig)
