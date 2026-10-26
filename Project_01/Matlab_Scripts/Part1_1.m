
% Software Lab 2.1 - Part 1.1
clear; clc; close all;

% Parameters
N = 100;          % Total number of symbols
sps = 100;        % Samples per symbol

% Generate independent random symbols (+1 or -1)
bc = 2*randi([0 1], 1, N) - 1;
bs = 2*randi([0 1], 1, N) - 1;

% Generate baseband signals
uc = repelem(bc, sps);
us = repelem(bs, sps);

% Time vector
t = (0:N*sps-1)/sps;

% Plot the first 10 symbols
figure;

subplot(2,1,1);
stairs(t, uc, 'b', 'LineWidth', 1.5);
title('In-Phase Baseband Signal u_c(t)');
xlabel('Time');
ylabel('Amplitude');
xlim([0 10]);
ylim([-1.5 1.5]);
grid on;

subplot(2,1,2);
stairs(t, us, 'r', 'LineWidth', 1.5);
title('Quadrature Baseband Signal u_s(t)');
xlabel('Time');
ylabel('Amplitude');
xlim([0 10]);
ylim([-1.5 1.5]);
grid on;
