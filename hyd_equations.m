%% Fundamental diagrams – SFPE stair (7"/11") vs Virkler corridor models
clear; clc;

%% Density vector (persons per square metre)
D = 0:0.01:4;

%% --- 1. SFPE stair (Chapter 59, k2 & a constants) ----------------------
k2 = 1.08;        % m/s   ← Table 59‑2 for 7"/11" stair  :contentReference[oaicite:0]{index=0}:contentReference[oaicite:1]{index=1}
a  = 0.266;       % slope ← Eq. 59‑5                      :contentReference[oaicite:2]{index=2}:contentReference[oaicite:3]{index=3}

S_sfpe = k2 * ones(size(D));          % free‑flow speed for D ≤ 0.54
idx     = D > 0.54;
S_sfpe(idx) = k2 .* (1 - a .* D(idx));
Q_sfpe = S_sfpe .* D;

%% --- 2. Virkler corridor models ---------------------------------------
S_greenShields = (63.97 - 17.12*D)/60;
Q_greenShields = (63.97*D   - 17.12*D.^2)/60;

S_bell  = 55   * exp(-0.172*D.^2)/60;
Q_bell  = 55.6 * D .* exp(-0.162*D.^2)/60;

S_under = 75.17 * exp(-D/4.1666)/60;
Q_under = 75.17 * D .* exp(-D/1.89)/60;

S_greenberg          = zeros(size(D));
mask                 = D < 1.07;
S_greenberg(mask)    = 58/60;
S_greenberg(~mask)   = (36.78 .* log(4.32 ./ D(~mask)))/60;
Q_greenberg          = S_greenberg .* D;

%% --- 3. Plot: Speed–density -------------------------------------------
figure('Name','Speed–density');
plot(D,S_sfpe,'k-','LineWidth',3.5); hold on
plot(D,S_greenShields,'LineWidth',2.0);
plot(D,S_bell,'LineWidth',2.0);
plot(D,S_under,'LineWidth',2.0);
plot(D,S_greenberg,'LineWidth',2.0);
set(gca,'FontSize',16); ylim([0 1.5]);
xlabel('Density (persons/m^2)'); ylabel('Speed (m/s)');
title('Speed–density relationship');
legend('SFPE stair 7"/11"','Greenshields','Bell shape','Underwood','Greenberg', ...
       'Location','northeast');

%% --- 4. Plot: Flow–density --------------------------------------------
figure('Name','Flow–density');
plot(D,Q_sfpe,'k-','LineWidth',3.5); hold on
plot(D,Q_greenShields,'LineWidth',2.0);
plot(D,Q_bell,'LineWidth',2.0);
plot(D,Q_under,'LineWidth',2.0);
plot(D,Q_greenberg,'LineWidth',2.0);
set(gca,'FontSize',16); ylim([0 1.2]);
xlabel('Density (persons/m^2)'); ylabel('Flow (persons/s)');
title('Flow–density relationship');
legend('SFPE stair 7"/11"','Greenshields','Bell shape','Underwood','Greenberg', ...
       'Location','north');
